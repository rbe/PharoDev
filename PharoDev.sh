#!/usr/bin/env bash
#
# Copyright (C) 2022 art of coding UG
# MIT License
#

set -o nounset
set -o errexit

declare PHARO_VERSION="100"
declare -a ACTIVATED_FEATURES=()

# TODO pharo-ide: Seamless, Ghost, ClassAnnotations
# https://github.com/pharo-open-documentation/awesome-pharo
# https://github.com/topics/pharo

declare -A FEATURES_DEFAULT_BRANCHES=(
    [Moose]="development"
    [MooseEasy]="v1.x.x"
    [Seaside-MaterialDesignLite]="development"
    [Exercism]="main"
)

declare -A FEATURE_CodeFonts=(
    [baseline]="CodeFonts"
    [githubUser]="astares"
    [project]="Pharo-CodeFonts"
    [commitish]="main"
    [path]="src"
)
declare -A FEATURE_Lobster=(
    [baseline]="Lobster"
    [githubUser]="sebastianconcept"
    [project]="lobster"
    [commitish]="0.1.1-alpha"
    [path]="src"
    [post-install]="Lobster start."
)
declare -A FEATURE_Grease=(
    [baseline]="Grease"
    [githubUser]="SeasideSt"
    [project]="Grease"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_OpenPonk_all=(
    [baseline]="OpenPonkPlugins"
    [githubUser]="openponk"
    [project]="plugins"
    [commitish]="master"
    [path]="src"
)
declare -A FEATURE_OpenPonk_ClassEditor=(
    [baseline]="ClassEditor"
    [githubUser]="openponk"
    [project]="class-editor"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_OpenPonk_BormEditor=(
    [baseline]="BormEditor"
    [githubUser]="openponk"
    [project]="borm-editor"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_OpenPonk_FsmEditor=(
    [baseline]="FsmEditor"
    [githubUser]="openponk"
    [project]="fsm-editor"
    [commitish]="master"
    [path]="repository"
 )
declare -A FEATURE_OpenPonk_PetriNets=(
    [baseline]="PetriNets"
    [githubUser]="openponk"
    [project]="petri-nets"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_OpenPonk_BPMN=(
    [baseline]="BPMN"
    [githubUser]="openponk"
    [project]="OpenPonk-BPMN"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_Moose=(
    [baseline]="Moose"
    [githubUser]="moosetechnology"
    [project]="Moose"
    [commitish]="master"
    [path]="src"
    [on]="on: MCMergeOrLoadWarning do: [ :warning | warning load ]"
)
declare -A FEATURE_MooseIDE=(
    [baseline]="MooseIDE"
    [githubUser]="moosetechnology"
    [project]="MooseIDE"
    [commitish]="development"
    [path]="src"
    [on]="on: MCMergeOrLoadWarning do: [ :warning | warning load ]"
)
declare -A FEATURE_MooseEasy=(
    [baseline]="MooseEasy"
    [githubUser]="moosetechnology"
    [project]="Moose-Easy"
    [commitish]="v1.x.x"
    [path]="src"
)
declare -A FEATURE_PlantUMLPharoGizmo=(
    [baseline]="PUGizmo"
    [githubUser]="fuhrmanator"
    [project]="PlantUMLPharoGizmo"
    [commitish]="master"
    [path]="src"
)
declare -A FEATURE_SoftwareAnalyzer=(
    [baseline]="SoftwareAnalyzer"
    [githubUser]="ObjectProfile"
    [project]="SoftwareAnalyzer"
    [commitish]="master"
    [path]="src"
    [on]="on: MCMergeOrLoadWarning do: [ :warning | warning load ]"
)
declare -A FEATURE_Spy2=(
    [baseline]="Spy2"
    [githubUser]="ObjectProfile"
    [project]="Spy2"
    [commitish]="v1.0"
    [path]=""
)
declare -A FEATURE_Roassal3=(
    [baseline]="Roassal3"
    [githubUser]="ObjectProfile"
    [project]="Roassal3"
    [commitish]="master"
    [path]="src"
    [load]="'Full' 'Roassal3-GraphViz'"
    [on]="on: MCMergeOrLoadWarning do: [ :warning | warning load ]"
)
declare -A FEATURE_Roassal3Exporters=(
    [baseline]="Roassal3Exporters"
    [githubUser]="ObjectProfile"
    [project]="Roassal3Exporters"
    [commitish]="master"
    [path]=""
)
declare -A FEATURE_DataStudio=(
    [baseline]="DataStudio"
    [githubUser]="ObjectProfile"
    [project]="DataStudio"
    [commitish]="master"
    [path]=""
)
declare -A FEATURE_STON=(
    [baseline]="Ston"
    [githubUser]="svenvc"
    [project]="ston"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_XML_Support_Pharo=(
    [baseline]=""
    [githubUser]="svenvc"
    [project]="XML-Support-Pharo"
    [commitish]="master"
    [path]=""
    [load]="'core'"
)
declare -A FEATURE_NeoJSON=(
    [baseline]="NeoJSON"
    [githubUser]="svenvc"
    [project]="NeoJSON"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_NeoCSV=(
    [baseline]="NeoCSV"
    [githubUser]="svenvc"
    [project]="NeoCSV"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_Commander2=(
    [baseline]="Commander2"
    [githubUser]="pharo-spec"
    [project]="Commander2"
    [commitish]="master"
    [path]="src"
)
declare -A FEATURE_Magritte=(
    [baseline]="Magritte"
    [githubUser]="magritte-metamodel"
    [project]="Magritte"
    [commitish]="master"
    [path]="source"
)
declare -A FEATURE_NewWave=(
    [baseline]="NewWave"
    [githubUser]="skaplar"
    [project]="NewWave"
    [commitish]="master"
    [path]=""
)
declare -A FEATURE_Spec=(
    [baseline]="Spec2"
    [githubUser]="pharo-spec"
    [project]="Spec"
    [commitish]="Pharo10"
    [path]=""
    [ignoreImage]="true"
)
declare -A FEATURE_HierarchicalVisualizations=(
    [baseline]="HierarchicalVisualizations"
    [githubUser]="ObjectProfile"
    [project]="HierarchicalVisualizations"
    [commitish]="main"
    [path]="src"
    [on]="on: MCMergeOrLoadWarning do: [ :warning | warning load ]"
)
declare -A FEATURE_Teapot=(
    [baseline]="Teapot"
    [githubUser]="zeroflag"
    [project]="Teapot"
    [commitish]="master"
    [path]="source"
)
declare -A FEATURE_Tealight=(
    [baseline]="Tealight"
    [githubUser]="astares"
    [project]="Tealight"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_Seaside=(
    [baseline]="Seaside3"
    [githubUser]="SeasideSt"
    [project]="Seaside"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_Seaside_Bootstrap5=(
    [baseline]="MaterialDesignLite"
    [githubUser]="DuneSt"
    [project]="MaterialDesignLite"
    [commitish]="master"
    [path]="src"
)
declare -A FEATURE_Seaside_MaterialDesignLite=(
    [baseline]="Bootstrap5"
    [githubUser]="astares"
    [project]="Seaside-Bootstrap5"
    [commitish]="master"
    [path]="src"
)
declare -A FEATURE_ZincHTTPComponents=(
    [baseline]="ZincHTTPComponents"
    [githubUser]="svenvc"
    [project]="zinc"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_mqtt=(
    [baseline]="MQTT"
    [githubUser]="svenvc"
    [project]="mqtt"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_stamp=(
    [baseline]="Stamp"
    [githubUser]="svenvc"
    [project]="stamp"
    [commitish]="master"
    [path]="repository"
)
declare -A FEATURE_memcached=(
    [baseline]="Memcached"
    [githubUser]="svenvc"
    [project]="Memcached"
    [commitish]="master"
    [path]=""
)
declare -A FEATURE_Artefact=(
    [baseline]="Artefact"
    [githubUser]="pharo-contributions"
    [project]="Artefact"
    [commitish]="master"
    [path]="src"
)
declare -A FEATURE_NeoConsole=(
    [baseline]="P3"
    [githubUser]="svenvc"
    [project]="P3"
    [commitish]="master"
    [path]=""
)
declare -A FEATURE_NeoConsole=(
    [baseline]="NeoConsole"
    [githubUser]="svenvc"
    [project]="NeoConsole"
    [commitish]="master"
    [path]="src"
)
declare -A FEATURE_Exercism=(
    [baseline]="Exercism"
    [githubUser]="exercism"
    [project]="pharo-smalltalk"
    [commitish]="master"
    [path]="releases/latest"
)

set -o errexit
set -o nounset

declare EXECDIR="$(pushd "$(dirname "$0")" >/dev/null; pwd ; popd >/dev/null)"
declare PROJECT_DIR="${PHARO_PROJECT_DIR:-$(pwd)}"

function show_usage() {
    echo ""
    echo "usage: $0 [ -h ]"
    echo "       $0 -n <name> [ -r <Git repository> ] [ -c [ -v <Pharo Version> ] [ -f <feature> ]... ]"
    echo "       $0 -n <name>"
    echo ""
    echo "    -n <name>       Name of Pharo image (to open)"
    echo ""
    echo "    -c              Create a new Pharo image"
    echo "    -f <feature>    feature ::= <githubUser/repo:branch[/directory]>"
    echo "    or:"
    echo "    -f <feature>    feature ::= <Feature name[,version,[onConflicts action]]>"
    echo "                       version ::= Version tag, see (GitHub) project"
    echo "                       onConflicts action ::= onConflictsUseIncoming | onConflictsUseLoaded"
    echo ""
    echo "                    Features"
    echo "                    ========"
    echo "                    Group Development:"
    echo "                    [ ] CodeFonts                  [ ] Lobster"
    echo "                    Group Libraries:"
    echo "                    [ ] Grease"
    echo "                    Group Modeling:"
    echo "                    [ ] OpenPonk-all               [ ] OpenPonk-ClassEditor [ ] OpenPonk-BormEditor"
    echo "                    [ ] OpenPonk-FsmEditor         [ ] OpenPonk-PetriNets   [ ] OpenPonk-BPMN"
    echo "                    Group Software Analysis:"
    echo "                    [ ] Moose                      [ ] MooseEasy            [ ] MooseIDE"
    echo "                    [ ] SoftwareAnalyzer           [ ] Spy2"
    echo ""
    echo "                    Group Data Structures:"
    echo "                    [ ] STON                       [ ] XML-Support-Pharo    [ ] NeoJSON"
    echo "                    [ ] NeoCSV"
    echo "                    Group nnn:"
    echo "                    [ ] Commander2                 [ ] Margritte            [ ] NewWave"
    echo "                    Group Visualization:"
    echo "                    [ ] Roassal3                   [ ] Roassal3Exporters    [ ] DataStudio"
    echo "                    [ ] HierarchicalVisualizations [ ] PlantUMLPharoGizmo"
    echo "                    Group Databases:"
    echo "                    [ ] P3"
    echo "                    Group Communication:"
    echo "                    [ ] ZincHTTPComponents.        [ ] stamp                [ ] mqtt"
    echo "                    Group Distributed Computing:"
    echo "                    [ ] memcached"
    echo "                    Group Web Development:"
    echo "                    [ ] Seaside                    [ ] Seaside-Bootstrap5   [ ] Seaside-MaterialDesignLite"
    echo "                    [ ] Teapot                     [ ] Tealight"
    echo "                    [ ] Artefact"
    echo "                    Group Management:"
    echo "                    [ ] NeoConsole"
    echo ""
    echo "Examples:"
    echo ""
    echo "    $0 -c -n MyProject -f Roassal3 -f Seaside3,v3.4.7"
    echo ""
}

declare MODE=""
declare NAME=""

while getopts "hcn:f:" opt
do
case "${opt}" in
h)
    show_usage
    exit 0
    ;;
c)
    MODE="create"
    ;;
n)
    PROJECT_NAME="${OPTARG}"
    ;;
f)
    ACTIVATED_FEATURES+=("${OPTARG}")
    ;;
v)
    PHARO_VERSION=${OPTARG}
    ;;
*)
    echo "Unknown option ${opt}"
    show_usage
    exit 1
    ;;
esac
done

#
# Check requirements
#

for cmd in curl sed; do
    if ! command -v "${cmd}" >/dev/null; then
        echo "$0: We need ${cmd}!"
        exit 1
    fi
done
if [[ -z "${PROJECT_NAME:-}" ]]; then
    echo "Project name missing"
    show_usage
    exit 1
fi

#
# Create project
#

function add_feature() {
    local feature_name="$1"
    local feature_version="${2:-}"
    local fdef="$(typeset -p FEATURE_"${feature_name}")"
    typeset -A f="${fdef#*=}"
    local cmd
    echo "Transcript show: 'Installing ${feature_name}'; cr."
    cmd+="[ Metacello new"
    cmd+="\n\tbaseline: '${f["baseline"]}';"
    cmd+="\n\trepository: 'github://${f["githubUser"]}/${f["project"]}"
    if [[ -z "${feature_version}" && -n "${f["commitish"]:-}" ]]; then
        cmd+=":${f["commitish"]}"
    elif [[ -n "${feature_version}" ]]; then
        cmd+=":${feature_version}"
    fi
    if [[ -n "${f["src"]:-}" ]]; then
        cmd+="/${f["src"]}"
    fi
    cmd+="';"
    cmd+="\n\tonWarningLog;"
    if [[ -n "${f["ignoreImage"]:-}" ]]; then
        cmd+="\n\tignoreImage;"
    fi
    #onConflictsUseLoaded
    #onConflictsUseIncoming
    if [[ -n "${f["load"]:-}" ]]; then
        cmd+="\n\tload: #(${f["load"]})"
    else
        cmd+="\n\tload"
    fi
    cmd+=" ]"
    if [[ -n "${f["on"]:-}" ]]; then
        cmd+="\n\t${f["on"]}"
    else
        cmd+=" value"
    fi
    cmd+="."
    echo -e $cmd
    echo "Transcript show: '${feature_name} installed'; cr."
    if [[ -n "${f["post-install"]:-}" ]]; then
        echo "Transcript show: 'Executing post-install action for ${feature_name}'; cr."
        echo -e "${f["post-install"]:-}"
    fi
}

PHARO_DIR="${HOME}/project/Pharo-${PROJECT_NAME}"

if [[ "${MODE}" == "create" ]]; then
    echo "Creating Pharo project '${PROJECT_NAME}'"
    mkdir -p "${PHARO_DIR}"
    pushd "${PHARO_DIR}" >/dev/null
    echo "Iceberg remoteTypeSelector: #httpsUrl." >PharoDevSetup.st
    for feature in "${ACTIVATED_FEATURES[@]}"; do
        feature_name="${feature//,*}"
        #feature_version="${feature//*,}"
        #if [[ "${feature_version}" == "${feature_name}" ]]; then
        #    feature_version="${FEATURES_DEFAULT_BRANCHES[${feature_name}]:-master}"
        #fi
        echo "Enabling feature '${feature_name}'"
        add_feature ${feature_name} | tee -a PharoDevSetup.st
    done
    echo "SmalltalkImage current snapshot: true andQuit: true." >>PharoDevSetup.st
    curl -fsSL "https://get.pharo.org/64/${PHARO_VERSION}+vm" |
        bash
    echo "Executing setup script"
    ./pharo --headless Pharo.image st PharoDevSetup.st | tee -a "$(basename $0).log" 2>&1
    if [[ -f PharoDevSetup.custom.st ]]; then
        echo "Executing custom setup script"
        ./pharo Pharo.image st PharoDevSetup.custom.st |
            tee -a "$(basename $0).custom.log" 2>&1
    fi
    popd >/dev/null
fi

#
# Open project
#

if [[ "${MODE}" == "" ]]; then
    if [[ -d "${PHARO_DIR}" ]]; then
        echo "Starting Pharo project '${PROJECT_NAME}'"
        pushd "${PHARO_DIR}" >/dev/null
        ./pharo 1>>"${PHARO_DIR}/$(basename $0).log" 2>&1 &
        popd >/dev/null
    else
        echo "Pharo project '${PROJECT_NAME}' does not exist"
        exit 1
    fi
fi

exit 0
