SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
OUTDIR="${SCRIPTPATH}/../hubDirectory/equCab3/bigBed/CTCF_loops"
mkdir -p $OUTDIR
for bed_file in ${SCRIPTPATH}/../data/ctcf_loops/*bed; do
  name=$(basename $bed_file _predicted_loops_merged.bed)
  ${SCRIPTPATH}/../tools/bedToBigBed -type=bed3 -tab -allow1bpOverlap $bed_file \
  data/equcab3.chrom.sizes $OUTDIR/${name}.bigBed
done