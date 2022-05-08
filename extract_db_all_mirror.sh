#!/bin/zsh

# CUTOUT PATHS
export CUTOUTS_DIR="database/cutouts"

# cutout basenames; we'll use this for unzipping
CUTOUTS_DUC1_BASENAME="DUC1.tar.bz2"
CUTOUTS_DUC2_1_BASENAME="DUC2_1.tar.gz"
CUTOUTS_DUC2_2_BASENAME="DUC2_2.tar.gz"

CUTOUTS_CSE3_BASENAME="CSE3.tar.bz2"
CUTOUTS_CSE4_1_BASENAME="CSE4_1.tar.gz"
CUTOUTS_CSE4_2_BASENAME="CSE4_2.tar.gz"
CUTOUTS_CSE5_1_BASENAME="CSE5_1.tar.gz"
CUTOUTS_CSE5_2_BASENAME="CSE5_2.tar.gz"

# DUC URLS
CUTOUTS_DUC1_URL="https://www.dropbox.com/s/i19j9mnrrvbpywp/DUC1.tar.bz2?dl=1"
# old link potentially causing file corruption:
# cutouts_url="https://www.dropbox.com/s/t2izj3dkzk81jg4/DUC2.tar.bz2?dl=1"
CUTOUTS_DUC2_1_URL="https://www.dropbox.com/s/7mqziqedmwtsiec/DUC2_1.tar.gz?dl=1"
CUTOUTS_DUC2_2_URL="https://www.dropbox.com/s/eu5bn4fgxr2kl97/DUC2_2.tar.gz?dl=1"
# CSE URLS
CUTOUTS_CSE3_URL="https://www.dropbox.com/s/o9ifb0mfe57e9w7/CSE3.tar.bz2?dl=1"
# old link potentially causing file corruption:
# cutouts_url="https://www.dropbox.com/s/ma3t1kcr95pgoip/CSE4.tar.bz2?dl=1"
CUTOUTS_CSE4_1_URL="https://www.dropbox.com/s/lm21d0vpaxb2u7j/CSE4_1.tar.gz?dl=1"
CUTOUTS_CSE4_2_URL="https://www.dropbox.com/s/9znelaty1gozmzs/CSE4_2.tar.gz?dl=1"
# old link potentially causing file corruption:
# cutouts_url="https://www.dropbox.com/s/viw9d2z3d90rfkz/CSE5.tar.bz2?dl=1"
CUTOUTS_CSE5_1_URL="https://www.dropbox.com/s/jqapt0getn8bsvn/CSE5_1.tar.gz?dl=1"
CUTOUTS_CSE5_2_URL="https://www.dropbox.com/s/zmzossyx1h2krv4/CSE5_2.tar.gz?dl=1"

export SCANS_DIR="database/scans"

SCANS_DUC1_BASENAME="DUC1.tar.bz2"
SCANS_DUC2_BASENAME="DUC2.tar.bz2"
SCANS_CSE3_BASENAME="CSE3.tar.bz2"
SCANS_CSE4_BASENAME="CSE4.tar.bz2"
SCANS_CSE5_BASENAME="CSE5.tar.bz2"

SCANS_DUC1_URL="https://www.dropbox.com/s/8xgyswufmeqelz3/DUC1.tar.bz2?dl=1"
SCANS_DUC2_URL="https://www.dropbox.com/s/917yljys8vaauwq/DUC2.tar.bz2?dl=1"
SCANS_CSE3_URL="https://www.dropbox.com/s/e6ito8hzyerkjqy/CSE3.tar.bz2?dl=1"
SCANS_CSE4_URL="https://www.dropbox.com/s/2482c4wnlf68gbh/CSE4.tar.bz2?dl=1"
SCANS_CSE5_URL="https://www.dropbox.com/s/loulws6o8hmmsd3/CSE5.tar.bz2?dl=1"

function download_building {
    # $arg1 -- cutout url
    # $arg2 -- base dir
    # $arg3 -- base name

    # skip existing.
    if [[ -f "${2}/${3}" ]]; then
        echo "${2}/${3} exists; skipping."
        return 0
    fi

    ARIA_BINARY=$(which aria2c)
    if [ -z ARIA_BINARY ]; then
        aria2c -c -x 8 -o "${2}/${3}" "\"${1}"\"
    else
        wget -O "${2}/${3}" "${1}"
    fi
}

function download_cutouts() {
    # $arg1 -- cutout url
    # $arg2 -- base name
    echo ${1} ${2}
    echo "download_building ${1} ${CUTOUTS_DIR} ${2}"
    download_building ${1} ${CUTOUTS_DIR} ${2}
}

function download_scans {
    # $arg1 -- scans url
    # $arg2 -- base name
    download_building ${1} ${SCANS_DIR} ${2}

}

function extract_files {
    # $arg1 folder where to extract

    for archive in $(ls -1 ${1}); do
        if [[ -d "${1}/${archive}" ]]; then
            continue
        fi

        filename=$(basename ${archive})
        extension=${filename##*\.}
        echo "FILENAME: ${filename} EXT: ${extension}"
        case "${extension}" in
        "gz")
            echo "tar -zxvf ${1}/${archive} -C ${1}"
            # tar -zxvf ${archive} -C ${1}
            ;;
        "bz2")
            echo "tar -jxvf ${1}/${archive} -C ${1}"
            ;;
        "zip")
            echo "zip"
            ;;
        *) echo "Extension not supported for ${archive}" ;;
        esac
    done
}

# a. cutouts
# DUC1
download_cutouts ${CUTOUTS_DUC1_URL} ${CUTOUTS_DUC1_BASENAME}

# DUC2
download_cutouts ${CUTOUTS_DUC2_1_URL} ${CUTOUTS_DUC2_1_BASENAME}
download_cutouts ${CUTOUTS_DUC2_2_URL} ${CUTOUTS_DUC2_2_BASENAME}

# cutouts_url="https://www.dropbox.com/s/7mqziqedmwtsiec/DUC2_1.tar.gz?dl=1"
# wget -O database/cutouts/DUC2_1.tar.gz $cutouts_url
# tar -zxvf database/cutouts/DUC2_1.tar.gz -C database/cutouts/

# cutouts_url="https://www.dropbox.com/s/eu5bn4fgxr2kl97/DUC2_2.tar.gz?dl=1"
# wget -O database/cutouts/DUC2_2.tar.gz $cutouts_url
# tar -zxvf database/cutouts/DUC2_2.tar.gz -C database/cutouts/
#old link potentially causing file corruption:
# cutouts_url="https://www.dropbox.com/s/t2izj3dkzk81jg4/DUC2.tar.bz2?dl=1"
# wget -O database/cutouts/DUC2.tar.bz2 $cutouts_url
# tar -jxvf database/cutouts/DUC2.tar.bz2 -C database/cutouts/

# CSE3
download_cutouts ${CUTOUTS_CSE3_URL} ${CUTOUTS_CSE3_BASENAME}
# download_building ${CUTOUTS_CSE3_URL} ${CUTOUTS_DIR} $
#wget -O database/cutouts/CSE3.tar.bz2 $cutouts_url
#tar -jxvf database/cutouts/CSE3.tar.bz2 -C database/cutouts/

# CSE4
# download_cutouts ${CUTOUTS_CSE4_1_URL} ${CUTOUTS_CSE4_BASENAME}
#tar -zxvf database/cutouts/CSE4_1.tar.gz -C database/cutouts/

download_cutouts ${CUTOUTS_CSE4_1_URL} ${CUTOUTS_CSE4_1_BASENAME}
download_cutouts ${CUTOUTS_CSE4_2_URL} ${CUTOUTS_CSE4_2_BASENAME}
# cutouts_url="https://www.dropbox.com/s/9znelaty1gozmzs/CSE4_2.tar.gz?dl=1"
# wget -O database/cutouts/CSE4_2.tar.gz $cutouts_url
#tar -zxvf database/cutouts/CSE4_2.tar.gz -C database/cutouts/

# wget -O database/cutouts/CSE4.tar.bz2 $cutouts_url
# tar -jxvf database/cutouts/CSE4.tar.bz2 -C database/cutouts/

# CSE5
download_cutouts ${CUTOUTS_CSE5_1_URL} ${CUTOUTS_CSE5_1_BASENAME}
download_cutouts ${CUTOUTS_CSE5_2_URL} ${CUTOUTS_CSE5_2_BASENAME}

extract_files ${CUTOUTS_DIR}

exit

#wget -O database/cutouts/CSE5_1.tar.gz $cutouts_url
#tar -zxvf database/cutouts/CSE5_1.tar.gz -C database/cutouts/

# cutouts_url="https://www.dropbox.com/s/zmzossyx1h2krv4/CSE5_2.tar.gz?dl=1"
# wget -O database/cutouts/CSE5_2.tar.gz $cutouts_url
#tar -zxvf database/cutouts/CSE5_2.tar.gz -C database/cutouts/
#old link potentially causing file corruption:
# cutouts_url="https://www.dropbox.com/s/viw9d2z3d90rfkz/CSE5.tar.bz2?dl=1"
# wget -O database/cutouts/CSE5.tar.bz2 $cutouts_url
# tar -jxvf database/cutouts/CSE5.tar.bz2 -C database/cutouts/

# b. scans

download_scans ${SCANS_DUC1_URL} ${SCANS_DUC1_BASENAME}
download_scans ${SCANS_DUC2_URL} ${SCANS_DUC2_BASENAME}
download_scans ${SCANS_CSE3_URL} ${SCANS_CSE3_BASENAME}
download_scans ${SCANS_CSE4_URL} ${SCANS_CSE4_BASENAME}
download_scans ${SCANS_CSE5_URL} ${SCANS_CSE5_BASENAME}

extract_files ${SCANS_DIR}
# tar -jxvf database/DUC1.tar.bz2 -C database/scans/

# c. alignments
src="database/alignments/zips"
dst="database/alignments"

wget -O $src/DUC1.zip "https://www.dropbox.com/s/djf0lvetc9nnx25/DUC1.zip?dl=1"
wget -O $src/DUC2.zip "https://www.dropbox.com/s/ywvyg0zldghyzkf/DUC2.zip?dl=1"
wget -O $src/CSE3.zip "https://www.dropbox.com/s/zx7927pe3fdbmvt/CSE3.zip?dl=1"
wget -O $src/CSE4.zip "https://www.dropbox.com/s/nuuykyyarvdynjp/CSE4.zip?dl=1"
wget -O $src/CSE5.zip "https://www.dropbox.com/s/jnojxclse7regf4/CSE5.zip?dl=1"

for this_zip in $(ls $src/*.zip); do
    this_dir=$(basename ${this_zip%.zip})
    unzip -d $dst"/"$this_dir $this_zip
done
