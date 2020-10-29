
#!/bin/bash
# Author: Franck MICHEL, University Cote d'Azur, CNRS, Inria

dataset=dataset-1-2

# Generate articles metadata
./run_xr2rml_metadata.sh         $dataset cord19_metadata sha   xr2rml_metadata_sha_tpl.ttl
./run_xr2rml_metadata.sh         $dataset cord19_metadata pmcid xr2rml_metadata_pmcid_tpl.ttl
./run_xr2rml_metadata_authors.sh cord19_json_light     xr2rml_metadata_authors_tpl.ttl

# Generate annotations for DBpedia Spotlight
./run_xr2rml_annotation.sh       $dataset title     spotlight_abstract     xr2rml_spotlight_tpl.ttl
./run_xr2rml_annotation.sh       $dataset abstract  spotlight_abstract     xr2rml_spotlight_tpl.ttl

# Generate annotations for Entity-fishing (title and abstract)
./run_xr2rml_annotation.sh       $dataset title     entityfishing_abstract xr2rml_entityfishing_tpl.ttl
./run_xr2rml_annotation.sh       $dataset abstract  entityfishing_abstract xr2rml_entityfishing_tpl.ttl

# Generate annotations for Entity-fishing (body)
./run_xr2rml_annotation_split.sh $dataset body_text entityfishing_0_body   xr2rml_entityfishing_tpl.ttl 10000000
./run_xr2rml_annotation_split.sh $dataset body_text entityfishing_1_body   xr2rml_entityfishing_tpl.ttl 10000000
./run_xr2rml_annotation_split.sh $dataset body_text entityfishing_2_body   xr2rml_entityfishing_tpl.ttl 10000000
./run_xr2rml_annotation_split.sh $dataset body_text entityfishing_3_body   xr2rml_entityfishing_tpl.ttl 10000000
./run_xr2rml_annotation_split.sh $dataset body_text entityfishing_4_body   xr2rml_entityfishing_tpl.ttl 10000000

# Generate annotations for NCBO Bioportal Annotator
./run_xr2rml_annotation.sh       $dataset title     ncbo     xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_0   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_1   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_2   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_3   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_4   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_5   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_6   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_7   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_8   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_9   xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_10  xr2rml_ncbo.ttl
./run_xr2rml_annotation.sh       $dataset abstract  ncbo_11  xr2rml_ncbo.ttl

# Generate arguments from ACTA
./run_xr2rml_acta.sh  $dataset  acta_components               xr2rml_acta_tpl.ttl
./run_xr2rml_acta.sh  $dataset  acta_components_participants  xr2rml_acta_pico_tpl.ttl
./run_xr2rml_acta.sh  $dataset  acta_components_outcomes      xr2rml_acta_pico_tpl.ttl
./run_xr2rml_acta.sh  $dataset  acta_components_intervention  xr2rml_acta_pico_tpl.ttl
