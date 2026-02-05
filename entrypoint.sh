#!/bin/bash -l


echo "sysmlv2-files: $1"
echo "exclude-sourcepaths: $2"
echo "feedback: $3"
echo "parseable-messages: $4"
echo "approximation-options $5"
echo "control-options $6"
echo "logging-options $7"
echo "optimization-options $8"
echo "path-splitting-options $9"
echo "rewriting-options ${10}"
echo "smt2-options ${11}"

AADL_DIR=${GITHUB_WORKSPACE}/$1

# Capture the version of Sireum used for this run
/Sireum/bin/sireum --version

runCommand=(/Sireum/bin/sireum hamr sysml logika)

if [[ -n $2 ]]; then
	excludePaths=$(echo $2 | jq -r 'join(",")')
	if [[ -n $excludePaths ]]; then
		runCommand+=(--exclude $excludePaths)
	fi
fi

if [[ -n $4 ]]; then
	if [ "XX $4" = "XX true" ]; then
		runCommand+=(--parseable-messages)
	else
		echo "Caution: non-parseable output"
	fi
fi

# Approximation options
if [[ -n $5 ]]; then
	cBitwidth=$(echo $5 | jq '."c-bitwidth" // empty')
	if [[ -n $cBitwidth ]]; then
		runCommand+=(--c-bitwidth $cBitwidth)
	fi
	fpRounding+=$(echo $5 | jq '."fp-rounding" // empty')
	if [[ -n $fpRounding ]]; then
		runCommand+=(--fp-rounding $fpRounding)
	fi
	useReal=$(echo $5 | jq '."use-real" // empty')
	if [ "XX $useReal" = 'XX "true"' ]; then
		runCommand+=(--use-real)
	fi
	zBitwidth=$(echo $5 | jq '."z-bitwidth" // empty')
	if [[ -n $zBitwidth ]]; then
		runCommand+=(--z-bitwidth $zBitwidth)
	fi
fi

# Control options
if [[ -n $6 ]]; then
	interprocedural=$(echo $6 | jq '."interprocedural" // empty')
	if [ "XX $interprocedural" = "XX true" ]; then
		runCommand+=(--interprocedural)
	fi
	interproceduralContracts=$(echo $6 | jq '."interprocedural-contracts" // empty')
	if [ "XX $interproceduralContracts" = "XX true" ]; then
		runCommand+=(--interprocedural-contracts)
	fi
	lineFocus=$(echo $6 | jq '."line" // empty')
	if [[ -n $lineFocus ]]; then
		runCommand+=(--line $lineFocus)
	fi
	loopBound=$(echo $6 | jq '."loop-bound" // empty')
	if [[ -n $loopBound ]]; then
		runCommand+=(--loop-bound $loopBound)
	fi
	recursiveBound=$(echo $6 | jq '."recursive-bound" // empty')
	if [[ -n $recursiveBound ]]; then
		runCommand+=(--recursive-bound $recursiveBound)
	fi
	patternInexhaustive=$(echo $6 | jq '."pattern-inexhaustive" // empty')
	if [ "XX $patternInexhaustive" = "XX true" ]; then
		runCommand+=(--pattern-inexhaustive)
	fi
	pureProofFun=$(echo $6 | jq '."pure-proof-fun" // empty')
	if [ "XX $pureProofFun" = "XX true" ]; then
		runCommand+=(--pure-proof-fun)
	fi
	satAssume=$(echo $6 | jq '."sat" // empty')
	if [ "XX $satAssume" = "XX true" ]; then
		runCommand+=(--sat)
	fi
	skipMethods=$(echo $6 | jq -r '."skip-methods" // empty | join(",")')
	if [[ -n $skipMethods ]]; then
		runCommand+=(--skip-methods $skipMethods)
	fi
	skipTypes=$(echo $6 | jq -r '."skip-types" // empty | join(",")')
	if [[ -n $skipTypes ]]; then
		runCommand+=(--skip-types $skipTypes)
	fi
fi

# Logging options
if [[ -n $7 ]]; then
	logPC=$(echo $7 | jq '."log-pc" // empty')
	if [ "XX $logPC" = "XX true" ]; then
		runCommand+=(--log-pc)
	fi
	logPCLines=$(echo $7 | jq '."log-pc-lines" // empty')
	if [ "XX $logPCLines" = "XX true" ]; then
		runCommand+=(--log-pc-lines)
	fi
	logRawPC=$(echo $7 | jq '."log-raw-pc" // empty')
	if [ "XX $logRawPC" = "XX true" ]; then
		runCommand+=(--log-raw-pc)
	fi
	logVC=$(echo $7 | jq '."log-vc" // empty')
	if [ "XX $logVC" = "XX true" ]; then
		runCommand+=(--log-vc)
	fi
	logVCDir=$(echo $7 | jq '."log-vc-dir" // empty')
	if [ "XX $logVCDir" = "XX true" ]; then
		runCommand+=(--log-vc-dir)
	fi
	logDetailedInfo=$(echo $7 | jq '."log-detailed-info" // empty')
	if [ "XX $logDetailedInfo" = "XX true" ]; then
		runCommand+=(--log-detailed-info)
	fi
	logRewriteAt=$(echo $7 | jq '."log-rewrite-at" // empty')
	if [ "XX $logRewriteAt" = "XX true" ]; then
		runCommand+=(--log-rewrite-at)
	fi
	logStats=$(echo $7 | jq '."stats" // empty')
	if [ "XX $logPC" = "XX true" ]; then
		runCommand+=(--stats)
	fi
	logStats=$(echo $7 | jq '."stats" // empty')
	if [ "XX $logPC" = "XX true" ]; then
		runCommand+=(--stats)
	fi
fi

# Optimization options
if [[ -n $8 ]]; then
	parallelizationEnable=$(echo $8 | jq '."parallelization-enable" // empty')
	if [ "XX $parallelizationEnable" = "XX true" ]; then
		runCommand+=(--par)
		parallelizationCorePercentage=$(echo $8 | jq '."parallelization-core-percentage" // empty')
		if [[ -n $parallelizationCorePercentage ]]; then
			runCommand+=($parallelizationCorePercentage)
		fi
	fi
	parallelizationBranch=$(echo $8 | jq '."parallelization-branch" // empty')
	if [ "XX $parallelizationBranch" = "XX true" ]; then
		runCommand+=(--par-branch)
	fi
	parallelizationBranchReturn=$(echo $8 | jq '."parallelization-branch-return" // empty')
	if [ "XX $parallelizationBranchReturn" = "XX true" ]; then
		runCommand+=(--par-branch-return)
	fi
	parallelizationBranchPredNum=$(echo $8 | jq '."parallelization-branch-pred-num" // empty')
	if [[ -n $parallelizationBranchPredNum ]]; then
		runCommand+=(--par-branch-pred-num $parallelizationBranchPredNum)
	fi
	parallelizationBranchPredComplexity=$(echo $8 | jq '."parallelization-branch-pred-complexity" // empty')
	if [[ -n $parallelizationBranchPredComplexity ]]; then
		runCommand+=(--par-branch-pred-complexity $parallelizationBranchPredComplexity)
	fi
	parallelizationRewriting=$(echo $8 | jq '."parallelization-rw" // empty')
	if [ "XX $parallelizationRewriting" = "XX true" ]; then
		runCommand+=(--par-rw)
	fi
fi

# Path-splitting options
if [[ -n $9 ]]; then
	dontSplitPfq=$(echo $9 | jq '."dont-split-pfq" // empty')
	if [ "XX $dontSplitPfq" = "XX true" ]; then
		runCommand+=(--dont-split-pfq)
	fi
	splitAll=$(echo $9 | jq '."split-all" // empty')
	if [ "XX $splitAll" = "XX true" ]; then
		runCommand+=(--split-all)
	fi
	splitContract=$(echo $9 | jq '."split-contract" // empty')
	if [ "XX $splitContract" = "XX true" ]; then
		runCommand+=(--split-contract)
	fi
	splitIf=$(echo $9 | jq '."split-if" // empty')
	if [ "XX $splitIf" = "XX true" ]; then
		runCommand+=(--split-if)
	fi
	splitMatch=$(echo $9 | jq '."split-match" // empty')
	if [ "XX $splitMatch" = "XX true" ]; then
		runCommand+=(--split-match)
	fi
fi

# Rewriting options
if [[ -n ${10} ]]; then
	rwMax=$(echo ${10} | jq '."rewriting-max" // empty')
	if [[ -n $rwMax ]]; then
		runCommand+=(--rw-max $rwMax)
	fi
	rwTrace=$(echo ${10} | jq '."rewriting-trace" // empty')
	if [ "XX $rwTrace" = 'XX "true"' ]; then
		runCommand+=(--rw-trace)
	fi
	rwEvalTrace=$(echo ${10} | jq '."rewriting-eval-trace" // empty')
	if [ "XX $rwEvalTrace" = "XX true" ]; then
		runCommand+=(--rw-eval-trace)
	fi
fi

# SMT2 options
if [[ -n ${11} ]]; then
	elideEncoding=$(echo ${11} | jq '."elide-encoding" // empty')
	if [ "XX $elideEncoding" = "XX true" ]; then
		runCommand+=(--elide-encoding)
	fi
	rawInscription=$(echo ${11} | jq '."raw-inscription" // empty')
	if [ "XX $rawInscription" = "XX true" ]; then
		runCommand+=(--raw-inscription)
	fi
	rlimit=$(echo ${11} | jq '."rlimit" // empty')
	if [[ -n $rlimit ]]; then
		runCommand+=(--rlimit $rlimit)
	fi
	smt2Seq=$(echo ${11} | jq '."seq" // empty')
	if [ "XX $smt2Seq" = "XX true" ]; then
		runCommand+=(--smt2-seq)
	fi
	simplify=$(echo ${11} | jq '."simplify" // empty')
	if [ "XX $simplify" = "XX true" ]; then
		runCommand+=(--simplify)
	fi
	solverSat=$(echo ${11} | jq '."solver-sat" // empty')
	if [[ -n $solverSat ]]; then
		runCommand+=(--solver-sat $solverSat)
	fi
	solverValid=$(echo ${11} | jq '."solver-valid" // empty')
	if [[ -n $solverValid ]]; then
		runCommand+=(--solver-valid $solverValid)
	fi
	satTimeout=$(echo ${11} | jq '."sat-timeout" // empty')
	if [[ -n $satTimeout ]]; then
		runCommand+=(--sat-timeout $satTimeout)
	fi
	timeout=$(echo ${11} | jq '."timeout" // empty')
	if [[ -n $timeout ]]; then
		runCommand+=(--timeout $timeout)
	fi
	searchPC=$(echo ${11} | jq '."search-pc" // empty')
	if [ "XX $searchPC" = "XX true" ]; then
		runCommand+=(--search-pc)
	fi
fi

# SysMLv2 files
runCommand+=($(echo $1 | jq -r 'join(" ")'))

outputFile="logika.out"
if [[ -n $3 ]]; then
	outputFile=$3
fi

echo "run command: ${runCommand[@]}" 

"${runCommand[@]}" >> "$outputFile"
EXIT_CODE=$?

echo "timestamp=$(date)" >> $GITHUB_OUTPUT
echo "status=${EXIT_CODE}" >> $GITHUB_OUTPUT
echo "status-messages=$(cat ${outputFile} | jq -R -s '.')" >> $GITHUB_OUTPUT

echo "exit code: $EXIT_CODE"
if [ "XX $EXIT_CODE" = "XX 0" ]; then
	exit 0
else
	exit 1
fi
