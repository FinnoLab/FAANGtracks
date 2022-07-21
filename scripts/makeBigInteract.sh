SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
OUTDIR="${SCRIPTPATH}/../hubDirectory/equCab3/bigBed/RE_Gene_pred"
mkdir -p $OUTDIR
sort -k1,1 -k2,2n ${SCRIPTPATH}/../data/RE_Gene_prediction/interact.bed > temp.interact.bb
${SCRIPTPATH}/../tools/bedToBigBed -as=data/bedsource/interact.as -type=bed5+13 -tab temp.interact.bb data/equcab3.chrom.sizes $OUTDIR/inter.bb
rm temp.interact.bb