set -e
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
OUTDIR="${SCRIPTPATH}/../hubDirectory/equCab3/bigBed/genePred"
#sed 's/MSY/chrY/g' ${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.annotated.gtf > ${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.annotated.renamed.gtf
${SCRIPTPATH}/../tools/gff3ToGenePred -rnaNameAttr=gene_name -geneNameAttr=attr=gene_name ${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.annotated.gff3 ${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.genePred
${SCRIPTPATH}/../tools/genePredToBigGenePred ${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.genePred \
${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.bigGenePred.txt
sort -k1,1 -k2,2n ${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.bigGenePred.txt > temp
mv temp ${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.bigGenePred.txt
${SCRIPTPATH}/../tools/bedToBigBed -type=bed12+8 -tab -as=${SCRIPTPATH}/../data/bedsource/bigGenePred.as \
${SCRIPTPATH}/../data/Genes/faang_refseq_ensembl.bigGenePred.txt \
${SCRIPTPATH}/../data/equcab3.chrom.sizes $OUTDIR/faang_genePred.bb
