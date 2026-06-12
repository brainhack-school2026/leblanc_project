.PHONY: all merge clean models brainmaps

all: brainmaps

# --------------------------
# 1. MERGE (prepare data)
# --------------------------
data/raw/data.csv:
	Rscript -e "rmarkdown::render('analyses/01_prepare_data.Rmd')"

merge: data/raw/data.csv

# --------------------------
# 2. CLEAN / PREPROCESS
# --------------------------
data/processed/data_ct_dst.csv \
data/processed/data_ct_dsk.csv \
data/processed/data_vol_aseg.csv \
data/processed/data_vol_dsk.csv \
data/processed/data_vol_dst.csv: data/raw/data.csv
	Rscript -e "rmarkdown::render('analyses/02_preliminary_analyses.Rmd')"

clean: data/processed/data_ct_dst.csv

# --------------------------
# 3. MODELS
# --------------------------
results/tables/tables.zip: \
	data/processed/data_ct_dst.csv \
	data/processed/data_ct_dsk.csv \
	data/processed/data_vol_aseg.csv \
	data/processed/data_vol_dsk.csv \
	data/processed/data_vol_dst.csv
	Rscript -e "rmarkdown::render('analyses/03_main_models.Rmd')"

models: results/tables/tables.zip

# --------------------------
# 4. BRAINS MAPS
# --------------------------
results/brainmaps/.done: results/tables/tables.zip
	Rscript -e "rmarkdown::render('analyses/04_generate_brainmaps.Rmd')"
	touch results/brainmaps/.done

brainmaps: results/brainmaps/.done

# --------------------------
# CLEAN ALL (optionnel reset)
# --------------------------
reset:
	rm -f data/raw/data.csv
	rm -f data/processed/*.csv
	rm -f results/tables/*.zip
	rm -f results/brainmaps/*.png
	rm -f results/brainmaps/.done
