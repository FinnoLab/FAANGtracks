table bed12Source
"Browser extensible data (12 fields) plus the source of this item."
    (
    string chrom;      "Chromosome (or contig, scaffold, etc.)"
    uint   chromStart; "Start position in chromosome"
    uint   chromEnd;   "End position in chromosome"
    string name;       "Name of item"
    uint   score;      "Score from 0-1000"
    char[1] strand;    "+ or -"
    string id;         "Peak ID"
    string ann;        "Peak annotation"
    )
