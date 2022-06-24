SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
OUTDIR="${SCRIPTPATH}/../hubDirectory/equCab3/bigBed/ATAC"
for bed_file in ${SCRIPTPATH}/../data/ATAC/annotated_bed/*bed; do
  name=$(basename $bed_file .bed | cut -d'.' -f 1)
  max=$(awk -F '\t' 'BEGIN{max=0} {if (int( $6 )>max) max=int( $6 )} END{print max}' $bed_file)
  min=$(awk -F '\t' '{if(NR==1) min=int( $6 )} {if (int( $6 )<min) min=int( $6 )} END{print min}' $bed_file)
  tail -n+2 $bed_file | \
  awk -v max=$max -v min=$min -F '\t' '{print $2"\t"$3"\t"$4"\t"NR"\t"int( 1000*((int( $6 ) - min))/(max - min) )"\t"$5"\t"$1"\t"$8}' \
  | sort -k1,1 -k2,2n - > ${SCRIPTPATH}/../data/ATAC/bedDetail/${name}.bedDetail
  ${SCRIPTPATH}/../tools/bedToBigBed -as=data/bedsource/atac_annotation_bed.as -type=bed6+2 -tab ${SCRIPTPATH}/../data/ATAC/bedDetail/${name}.bedDetail \
data/equcab3.chrom.sizes $OUTDIR/${name}.bigBed
done

OUTDIR="${SCRIPTPATH}/../hubDirectory/equCab3/bigBed/ChromHMM"
for bed_file in ${SCRIPTPATH}/../data/chromatin_states/*bed; do
  name=$(basename $bed_file .bed | cut -d'.' -f 1)
  tail -n+3 $bed_file | sort -k1,1 -k2,2n - > temp
  mv temp $bed_file.sorted
  ${SCRIPTPATH}/../tools/bedToBigBed -type=bed12 -tab -allow1bpOverlap $bed_file.sorted \
  data/equcab3.chrom.sizes $OUTDIR/${name}.bigBed
done
