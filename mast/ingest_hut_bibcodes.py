#!/usr/bin/env python

"""
Read in the HUT bibliographic data; we also require the obscore table
to support mapping between the records.

"""

import sys 

#import hashlib
import urllib
import base64

from psv import open_obscore, get_column
from namespaces import *

from rdflib import URIRef, Graph

from mast_utils import *

def getBibliography(fname):
    """Extract the <bibcode obsid> values from fname."""

    fh = open(fname, "r")
    out = {}
    for l in fh.readlines():
        args = l.strip().split()
        if len(args) != 2:
            print("SKIPPING: [{0}]".format(l))

        else:
            bibcode = args[0]
            obsid = args[1]
            try:
                out[obsid].append(bibcode)

            except KeyError:
                out[obsid] = [bibcode]

    fh.close()
    return out

def writeBibliographyFile(fname, ohead, bibcodes, format="n3"):
    """Write out bibliographic records using the obscore table in fname.

    bibcodes is a dictionary with key: obsid, value: list of bibcodes.

    The output is written to
    
        ohead.<format>

    """

    (rdr, fh) = open_obscore(fname)

    graph = makeGraph()

    nbib = 0
    for row in rdr:

        obs_id = get_column(row, "obs_id")
        access_url = get_column(row, "access_url")

        for (k,bs) in bibcodes.iteritems():
            # The HUT bibcodes appear to use obsid values which are
            # prefixes of the obscore ones.
            #
            if not obs_id.startswith(k):
                continue

            # Create the URIs that represent the data and observation objects from
            # the obscore table.
            #
            uri_hash = base64.urlsafe_b64encode(access_url[::-1])
            daturi = mkURI("/obsv/MAST/obsid/{0}/data/".format(obs_id), uri_hash)
            obsuri = mkURI("/obsv/MAST/obsid/{0}/observation/".format(obs_id), uri_hash)

            # Loop through each bibcode, linking them to the data/observation URIs
            #
            for b in bs:
                biburi = URIRef(ads_baseurl + "/bib#" + cleanFragment(b))
                gadd(graph, biburi, adsbase.aboutScienceProduct, daturi)
                gadd(graph, biburi, adsbase.aboutScienceProcess, obsuri)


            nbib += len(bs)
            print("# bibcodes = {0}".format(nbib))

    fh.close()

    writeGraph(graph, "{0}.{1}".format(ohead, format), format=format)
    
if __name__=="__main__":
    nargs = len(sys.argv)
    if nargs in [3,4] :
        import os.path
        oname = sys.argv[1]
        bname = sys.argv[2]
        if nargs == 3:
            fmt = "rdf"
        else:
            fmt = sys.argv[3]

        validateFormat(fmt)
        
        bibcodes = getBibliography(bname)
        writeBibliographyFile(oname,
                              "tests/mast/" + os.path.basename(bname),
                              bibcodes, format=fmt)

    else:
        sys.stderr.write("Usage: {0} <MAST obscore> <HUT bibcode> [rdf|n3]\n".format(sys.argv[0]))
        sys.exit(-1)


