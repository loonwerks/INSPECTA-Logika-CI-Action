# INSPECTA-Logika-CI-Action

INSPECTA CI action to conduct Logika analysis on a SySML (v2) model

## Inputs

### `sysmlv2-files`

**Required** JSON-formatted list of SySML model files to include in the analysis. 

### `sourcepaths`

JSON-formatted list of Source paths of SysML v2 .sysml files (expects path strings.  Default: '[]'.

### `exclude-sourcepaths`

JSON-formatted list of sourcepath URI segments to exclude from the analysis.  Default: '[]'.

### `feedback`

Feedback output directory (expects a path).  Default '.'.

### `parseable-messages`

Print parseable file messages.  Default 'false'.

### `approximation-options`

The following approximation options are supported:

+ c-bitwidth:
  - description: 'Bit-width representation for C (character) values (expected 8, 16, or 32).'
  - required: false
  - default: '32'
+ fp-rounding:
  - description: 'Rounding mode for floating point numbers (expects one of { NearestTiesToEven, NearestTiesToAway, TowardPositive, TowardNegative, TowardZero }.'
  - required: false
  - default: 'NearestTiesToEven'
+ use-real:
  - description: 'Use reals to approximate floating-point numbers.'
  - required: false
  - default: 'false'
+ z-bitwidth:
  - description: 'Bit-width representation for Z (integer) values (expected 0, 8, 16, 32, 64).'
  - required: false
  - default: '0'

Approximation options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
    "c-bitwidth" : 32
    "fp-rounding" : "TowardPositive"
    "use-real" : "false"
    "z-bitwidth" : 0
}
~~~

### `control-options`

The following control options are supported:

+ interprocedural:
  - description: 'Enable inter-procedural verification on non-strict-pure methods'
  - required: false
  - default: 'false'
+ interprocedural-contracts:
  - description: 'Use contracts in inter-procedural verification.'
  - required: false
  - default: 'false'
+ strictpure-mode:
  - description: 'Strict-pure method treatment mode in compositional/interprocedural verification (expects one of { default, flip, uninterpreted }.'
  - required: false
  - default: 'default'
+ line:
  - description: 'Focus verification to the specified program line number (expects an integer; min is 0).'
  - required: false
  - default: '0'
+ loop-bound:
  - description: 'Loop bound for inter-procedural verification (expects an integer; min is 1).'
  - required: false
  - default: '3'
+ recursive-bound:
  - description: 'Recursive call-chain bound for inter-procedural verification (expects an integer; min is 1)'
  - required: false
  - default: '3'
+ pattern-inexhaustive:
  - description: 'Disable pattern exhaustiveness checking.'
  - required: false
  - default: 'false'
+ pure-proof-fun:
  - description: 'Always add proof functions for pure methods.'
  - required: false
  - default: 'false'
+ sat:
  - description: 'Enable assumption satisfiability checking.'
  - required: false
  - default: 'false'
+ skip-methods:
  - description: 'Skip checking methods with the specified fully-qualified names or identifiers (expects a JSON-formatted string list).'
  - required: false
  - default: '[]'
+ skip-types:
  - description: 'Skip checking traits, classes, and objects with the specified fully-qualified names or identifiers (expects a JSON-formatted string list).'
  - required: false
  - default: '[]'

Control options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "interprocedural" : "false"
  "interprocedural-contracts" : "false"
  "strictpure-mode" : "default"
  "line" : 0
  "loop-bound" : 3
  "recursive-bound" : 3
  "pattern-inexhaustive" : "false"
  "pure-proof-fun" : "false"
  "sat" : "false"
  "skip-methods" : "[]"
  "skip-types : "[]"
}
~~~

### `logging-options`

The following logging options are supported:

+ log-pc:
  - description: 'Display path conditions before each statement.'
  - required: false
  - default: 'false'
+ log-pc-lines:
  - description: 'Display At(...) path condition line numbers and unique  symbolic value numbering.'
  - required: false
  - default: 'false'
+ log-raw-pc:
  - description: 'Display raw path conditions before each statement.'
  - required: false
  - default: 'false'
+ log-vc:
  - description: 'Display all verification conditions.'
  - required: false
  - default: 'false'
+ log-vc-dir:
  - description: 'Write all verification conditions in a directory (expects a path).'
  - required: false
  - default: ''
+ log-detailed-info:
  - description: 'Display detailed feedback information.'
  - required: false
  - default: 'false'
+ log-rewrite-at:
  - description: 'Disable At(...) rewriting as In(...)/Old(...) in symexe mode.'
  - required: false
  - default: 'false'
+ stats:
  - description: 'Collect verification statistics.'
  - required: false
  - default: 'false'

Logging options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "log-pc" : "false"
  "log-pc-lines : "false"
  "log-raw-pc" : "false"
  "log-vc" : "false"
  "log-vc-dir" : ""
  "log-detailed-info : "false"
  "log-rewrite-at" : "false"
  "stats" : "false"
}
~~~

### `optimization-options`

The following optimization options are supported:

+ parallelization-enable:
  - description: 'Enable parallelization.'
  - required: false
  - default: 'false'
+ parallelization-core-percentage:
  - description: 'CPU cores percentage to use (effective only if parallelization is enabled, accepts an integer; min is 1; max is 100).'
  - required: false
  - default: '100'
+ parallelization-branch:
  - description: 'Enable branch parallelization.'
  - required: false
  - default: 'false'
+ parallelization-branch-return:
  - description: 'Only use branch parallelization if all branches return.'
  - required: false
  - default: 'false'
+ parallelization-branch-pred-num:
  - description: 'Branch parallelization prediction minimum number of branches (expects an integer; min is 3).'
  - required: false
  - default: '2'
+ parallelization-branch-pred-complexity:
  - description: 'Branch parallelization prediction statement complexity (expects an integer; min is 0).'
  - required: false
  - default: '0'
+ parallelization-rw:
  - description: 'Enable rewriting parallelization.'
  - required: false
  - default: 'false'

Optimization options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "parallelization-enable" : "false"
  "parallelization-core-percentage" : 100
  "parallelization-branch" : "false"
  "parallelization-branch-return" : "false"
  "parallelization-branch-pred-num" : 2
  "parallelization-branch-pred-complexity" : 0
  "parallelization-rw" : "false"
}
~~~

### `path-splitting-options`

The following path-splitting options are supported:

+ dont-split-pfq:
  - description: 'Do not force splitting in quantifiers and proof functions derived from @strictpure methods.'
  - required: false
  - default: 'false'
+ split-all:
  - description: 'Split all paths.'
  - required: false
  - default: 'false'
= split-contract:
  - description: 'Split on contract cases.'
  - required: false
  - default: 'false'
= split-if:
  - description: 'Split on if-conditional expressions and statements.'
  - required: false
  - default: 'false'
+ split-match:
  - description: 'Split on match expressions and statements.'
  - required: false
  - default: 'false'

Path-splitting options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "dont-split-pfq" : "false"
  "split-all" : false"
  "split-contract" : "false"
  "split-if" : false"
  "split-match" : "false"
}
~~~

### `rewriting-options`

The following rewriting options are supported:

+ rewriting-max:
  - description: 'Maximum number of rewriting (expects an integer; min is 1).'
  - required: false
  - default: '100'
+ rewriting-disable-trace:
  - description: 'Disable rewriting trace.'
  - required: false
  - default: 'false'
+ rewriting-disable-eval-trace:
  - description: 'Disable evaluation rewriting trace.'
  - required: false
  - default: 'false'

Rewriting options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
  "rewriting-max" : 100
  "rewriting-disable-trace" : "false"
  "rewriting-disable-eval-trace" : "false"
}
~~~

### `smt2-options`

The following SMT2 solver options are supported:

+ elide-encoding:
  - description: 'Strip out SMT2 encoding in feedback'
  - required: false
  - default: 'false'
+ raw-inscription:
  - description: 'Use raw sequent/sat preamble inscription.'
  - required: false
  - default: 'false'
+ rlimit:
  - description: 'SMT2 solver resource limit (expects an integer; min is 0).'
  - required: false
  - default: '2000000'
+ seq:
  - description: 'Disable SMT2 solvers parallelization.'
  - required: false
  - default: 'false'
+ simplify:
  - description: 'Simplify SMT2 query (experimental).'
  - required: false
  - default: 'false'
+ solver-sat:
  - description: 'SMT2 configurations for satisfiability queries (expects a string).'
  - required: false
  - default: 'z3'
+ solver-valid:
  - description: 'SMT2 configurations for validity queries (expects a string; default is "cvc4, --full-saturate-quant; z3; cvc5,--full-saturate-quant").'
  - required: false
  -  default: ''
+ sat-timeout:
  - description: 'Use validity checking timeout for satisfiability checking (otherwise: 500ms).'
  - required: false
  - default: 'false'
+ timeout:
  - description: 'Timeout (seconds) for validity checking (expects an integer; min is 1).'
  - required: false
  - default: '2'
+ search-pc:
  - description: 'Search path conditions first before employing SMT2 solvers when discharging VCs.'
  - required: false
  - default: 'false'

SMT2 solver options in JSON-formatted dictionary as shown below.  All key-value pairs are optional.

~~~
{
    "elide-encoding" : "false"
    "raw-inscription" : "false"
    "rlimit" : 2000000
    "seq" : "false"
    "simplify" : "false"
    "solver-sat" : "z3"
    "solver-valid" : ""
    "solver-timeout" : "false"
    "timeout" : 2
    "search-pc" : "false"
}
~~~


## Outputs

## `result`

The JSON-formatted summary of analysis results.

## Example usage

uses: actions/AGREE-CI-Action@v1
with:
  component-to-analyze: 'Octocat.impl'
