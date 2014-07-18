type {:extern} name;

type {:extern} byte;

function {:extern} OneByteToInt(byte) : int;

function {:extern} TwoBytesToInt(byte, byte) : int;

function {:extern} FourBytesToInt(byte, byte, byte, byte) : int;

axiom (forall b0: byte, c0: byte :: { OneByteToInt(b0), OneByteToInt(c0) } OneByteToInt(b0) == OneByteToInt(c0) ==> b0 == c0);

axiom (forall b0: byte, b1: byte, c0: byte, c1: byte :: { TwoBytesToInt(b0, b1), TwoBytesToInt(c0, c1) } TwoBytesToInt(b0, b1) == TwoBytesToInt(c0, c1) ==> b0 == c0 && b1 == c1);

axiom (forall b0: byte, b1: byte, b2: byte, b3: byte, c0: byte, c1: byte, c2: byte, c3: byte :: { FourBytesToInt(b0, b1, b2, b3), FourBytesToInt(c0, c1, c2, c3) } FourBytesToInt(b0, b1, b2, b3) == FourBytesToInt(c0, c1, c2, c3) ==> b0 == c0 && b1 == c1 && b2 == c2 && b3 == c3);

var {:extern} Mem: [name][int]int;

var {:extern} alloc: int;

function {:extern} Field(int) : name;

function {:extern} Base(int) : int;

axiom (forall x: int :: { Base(x) } INT_LEQ(Base(x), x));

var {:extern} Mem_T.CHAR: [int]int;

var {:extern} Mem_T.FLOAT: [int]int;

var {:extern} Mem_T.INT4: [int]int;

function {:extern} Match(a: int, t: name) : bool;

function {:extern} MatchBase(b: int, a: int, t: name) : bool;

function {:extern} HasType(v: int, t: name) : bool;

function {:extern} T.Ptr(t: name) : name;

axiom (forall a: int, t: name :: { Match(a, T.Ptr(t)) } Match(a, T.Ptr(t)) <==> Field(a) == T.Ptr(t));

axiom (forall b: int, a: int, t: name :: { MatchBase(b, a, T.Ptr(t)) } MatchBase(b, a, T.Ptr(t)) <==> Base(a) == b);

axiom (forall v: int, t: name :: { HasType(v, T.Ptr(t)) } HasType(v, T.Ptr(t)) <==> v == 0 || (INT_GT(v, 0) && Match(v, t) && MatchBase(Base(v), v, t)));

const {:extern} unique T.CHAR: name;

const {:extern} unique T.FLOAT: name;

const {:extern} unique T.INT4: name;

const {:extern} unique T.PCHAR: name;

const {:extern} unique T.PFLOAT: name;

const {:extern} unique T.PINT4: name;

function {:extern}  INT_EQ(x: int, y: int) : bool
{
  x == y
}

function {:extern}  INT_NEQ(x: int, y: int) : bool
{
  x != y
}

function {:extern}  INT_ADD(x: int, y: int) : int
{
  x + y
}

function {:extern}  INT_SUB(x: int, y: int) : int
{
  x - y
}

function {:extern}  INT_LT(x: int, y: int) : bool
{
  x < y
}

function {:extern}  INT_ULT(x: int, y: int) : bool
{
  x < y
}

function {:extern}  INT_LEQ(x: int, y: int) : bool
{
  x <= y
}

function {:extern}  INT_ULEQ(x: int, y: int) : bool
{
  x <= y
}

function {:extern}  INT_GT(x: int, y: int) : bool
{
  x > y
}

function {:extern}  INT_UGT(x: int, y: int) : bool
{
  x > y
}

function {:extern}  INT_GEQ(x: int, y: int) : bool
{
  x >= y
}

function {:extern}  INT_UGEQ(x: int, y: int) : bool
{
  x >= y
}

function {:extern} INT_AND(a: int, b: int) : int;

axiom (forall a: int, b: int :: { INT_AND(a, b) } a == b ==> INT_AND(a, b) == a);

axiom (forall a: int, b: int :: { INT_AND(a, b) } POW2(a) && POW2(b) && a != b ==> INT_AND(a, b) == 0);

axiom (forall a: int, b: int :: { INT_AND(a, b) } a == 0 || b == 0 ==> INT_AND(a, b) == 0);

function {:extern} INT_OR(a: int, b: int) : int;

function {:extern} INT_XOR(a: int, b: int) : int;

function {:extern} INT_NOT(a: int) : int;

function {:extern} POW2(a: int) : bool;

axiom POW2(1);

axiom POW2(2);

axiom POW2(4);

axiom POW2(8);

axiom POW2(16);

axiom POW2(32);

axiom POW2(64);

axiom POW2(128);

axiom POW2(256);

axiom POW2(512);

axiom POW2(1024);

axiom POW2(2048);

axiom POW2(4096);

axiom POW2(8192);

axiom POW2(16384);

axiom POW2(32768);

axiom POW2(65536);

axiom POW2(131072);

axiom POW2(262144);

axiom POW2(524288);

axiom POW2(1048576);

axiom POW2(2097152);

axiom POW2(4194304);

axiom POW2(8388608);

axiom POW2(16777216);

axiom POW2(33554432);

function {:extern} INT_MINUS_BOTH_PTR_OR_BOTH_INT(a: int, b: int, size: int) : int;

axiom (forall a: int, b: int, size: int :: { INT_MINUS_BOTH_PTR_OR_BOTH_INT(a, b, size) } size * INT_MINUS_BOTH_PTR_OR_BOTH_INT(a, b, size) <= a - b && a - b < size * (INT_MINUS_BOTH_PTR_OR_BOTH_INT(a, b, size) + 1));

function {:extern} INT_MINUS_LEFT_PTR(a: int, a_size: int, b: int) : int;

axiom (forall a: int, a_size: int, b: int :: { INT_MINUS_LEFT_PTR(a, a_size, b) } INT_MINUS_LEFT_PTR(a, a_size, b) == a - a_size * b);

function {:extern} INT_PLUS(a: int, a_size: int, b: int) : int;

axiom (forall a: int, a_size: int, b: int :: { INT_PLUS(a, a_size, b) } INT_PLUS(a, a_size, b) == a + a_size * b);

function {:extern} INT_MULT(a: int, b: int) : int;

axiom (forall a: int, b: int :: { INT_MULT(a, b) } INT_MULT(a, b) == a * b);

function {:extern} INT_DIV(a: int, b: int) : int;

axiom (forall a: int, b: int :: { INT_DIV(a, b) } a >= 0 && b > 0 ==> b * INT_DIV(a, b) <= a && a < b * (INT_DIV(a, b) + 1));

axiom (forall a: int, b: int :: { INT_DIV(a, b) } a >= 0 && b < 0 ==> b * INT_DIV(a, b) <= a && a < b * (INT_DIV(a, b) - 1));

axiom (forall a: int, b: int :: { INT_DIV(a, b) } a < 0 && b > 0 ==> b * INT_DIV(a, b) >= a && a > b * (INT_DIV(a, b) - 1));

axiom (forall a: int, b: int :: { INT_DIV(a, b) } a < 0 && b < 0 ==> b * INT_DIV(a, b) >= a && a > b * (INT_DIV(a, b) + 1));

function {:extern} INT_BINARY_BOTH_INT(a: int, b: int) : int;

function {:extern}  BV32_EQ(x: bv32, y: bv32) : bool
{
  x == y
}

function {:extern}  BV32_NEQ(x: bv32, y: bv32) : bool
{
  x != y
}

function {:extern} {:bvbuiltin "bvadd"} BV32_ADD(x: bv32, y: bv32) : bv32;

function {:extern} {:bvbuiltin "bvsub"} BV32_SUB(x: bv32, y: bv32) : bv32;

function {:extern} {:bvbuiltin "bvmul"} BV32_MULT(x: bv32, y: bv32) : bv32;

function {:extern} {:bvbuiltin "bvudiv"} BV32_DIV(x: bv32, y: bv32) : bv32;

function {:extern} {:bvbuiltin "bvult"} BV32_ULT(x: bv32, y: bv32) : bool;

function {:extern} {:bvbuiltin "bvslt"} BV32_LT(x: bv32, y: bv32) : bool;

function {:extern} {:bvbuiltin "bvule"} BV32_ULEQ(x: bv32, y: bv32) : bool;

function {:extern} {:bvbuiltin "bvsle"} BV32_LEQ(x: bv32, y: bv32) : bool;

function {:extern} {:bvbuiltin "bvugt"} BV32_UGT(x: bv32, y: bv32) : bool;

function {:extern} {:bvbuiltin "bvsgt"} BV32_GT(x: bv32, y: bv32) : bool;

function {:extern} {:bvbuiltin "bvuge"} BV32_UGEQ(x: bv32, y: bv32) : bool;

function {:extern} {:bvbuiltin "bvsge"} BV32_GEQ(x: bv32, y: bv32) : bool;

function {:extern} {:bvbuiltin "bvand"} BV32_AND(a: bv32, b: bv32) : bv32;

function {:extern} {:bvbuiltin "bvor"} BV32_OR(a: bv32, b: bv32) : bv32;

function {:extern} {:bvbuiltin "bvxor"} BV32_XOR(a: bv32, b: bv32) : bv32;

function {:extern} {:bvbuiltin "bvnot"} BV32_NOT(a: bv32) : bv32;

function {:extern}  BV32_MINUS_BOTH_PTR_OR_BOTH_INT(a: bv32, b: bv32, size: bv32) : bv32
{
  BV32_DIV(BV32_SUB(a, b), size)
}

function {:extern}  BV32_MINUS_LEFT_PTR(a: bv32, a_size: bv32, b: bv32) : bv32
{
  BV32_SUB(a, BV32_MULT(a_size, b))
}

function {:extern}  BV32_PLUS(a: bv32, a_size: bv32, b: bv32) : bv32
{
  BV32_ADD(a, BV32_MULT(a_size, b))
}

function {:extern} BV32_BINARY_BOTH_INT(a: bv32, b: bv32) : bv32;

function {:extern} bv32ToInt(bv32) : int;

function {:extern} intToBv32(int) : bv32;

function {:extern} choose(a: bool, b: int, c: int) : int;

axiom (forall a: bool, b: int, c: int :: { choose(a, b, c) } a ==> choose(a, b, c) == b);

axiom (forall a: bool, b: int, c: int :: { choose(a, b, c) } !a ==> choose(a, b, c) == c);

function {:extern} LIFT(a: bool) : int;

axiom (forall a: bool :: { LIFT(a) } a <==> LIFT(a) != 0);

function {:extern} PTR_NOT(a: int) : int;

axiom (forall a: int :: { PTR_NOT(a) } a == 0 ==> PTR_NOT(a) != 0);

axiom (forall a: int :: { PTR_NOT(a) } a != 0 ==> PTR_NOT(a) == 0);

function {:extern} NULL_CHECK(a: int) : int;

axiom (forall a: int :: { NULL_CHECK(a) } a == 0 ==> NULL_CHECK(a) != 0);

axiom (forall a: int :: { NULL_CHECK(a) } a != 0 ==> NULL_CHECK(a) == 0);

procedure {:extern} havoc_assert(i: int);
  requires i != 0;



procedure {:extern} havoc_assume(i: int);
  ensures i != 0;



procedure {:extern} __HAVOC_free(a: int);



function {:extern} NewAlloc(x: int, y: int) : int;

procedure {:extern} __HAVOC_malloc(obj_size: int) returns (new: int);
  requires INT_GEQ(obj_size, 0);
  modifies alloc;
  ensures new == old(alloc);
  ensures INT_GT(alloc, INT_ADD(new, obj_size));
  ensures Base(new) == new;
  ensures INT_GEQ(new, 0);



procedure {:extern} __HAVOC_det_malloc(obj_size: int) returns (new: int);
  requires INT_GEQ(obj_size, 0);
  modifies alloc;
  ensures new == old(alloc);
  ensures INT_GT(alloc, INT_ADD(new, obj_size));
  ensures Base(new) == new;
  ensures alloc == NewAlloc(old(alloc), obj_size);
  ensures INT_GEQ(new, 0);



procedure {:extern} __HAVOC_memset_split_1(A: [int]int, p: int, c: int, n: int) returns (ret: [int]int);
  ensures Subset(Empty(), Array(p, 1, n)) && (forall i: int :: { ret[i] } Array(p, 1, n)[i] || ret[i] == A[i]);
  ensures Subset(Empty(), Array(p, 1, n)) && (forall i: int :: { ret[i] } Array(p, 1, n)[i] ==> ret[i] == c);



procedure {:extern} __HAVOC_memset_split_2(A: [int]int, p: int, c: int, n: int) returns (ret: [int]int);
  ensures Subset(Empty(), Array(p, 2, n)) && (forall i: int :: { ret[i] } Array(p, 2, n)[i] || ret[i] == A[i]);
  ensures Subset(Empty(), Array(p, 2, n)) && (forall i: int :: { ret[i] } Array(p, 2, n)[i] ==> ret[i] == c);



procedure {:extern} __HAVOC_memset_split_4(A: [int]int, p: int, c: int, n: int) returns (ret: [int]int);
  ensures Subset(Empty(), Array(p, 4, n)) && (forall i: int :: { ret[i] } Array(p, 4, n)[i] || ret[i] == A[i]);
  ensures Subset(Empty(), Array(p, 4, n)) && (forall i: int :: { ret[i] } Array(p, 4, n)[i] ==> ret[i] == c);



procedure {:extern} nondet_choice() returns (x: int);



var {:extern} detChoiceCnt: int;

function {:extern} DetChoiceFunc(a: int) : int;

procedure {:extern} det_choice() returns (x: int);
  modifies detChoiceCnt;
  ensures detChoiceCnt == INT_ADD(old(detChoiceCnt), 1);
  ensures x == DetChoiceFunc(old(detChoiceCnt));



procedure {:extern} _strdup(str: int) returns (new: int);



procedure {:extern} _xstrcasecmp(a0: int, a1: int) returns (ret: int);



procedure {:extern} _xstrcmp(a0: int, a1: int) returns (ret: int);



var {:extern} Res_KERNEL_SOURCE: [int]int;

var {:extern} Res_PROBED: [int]int;

function {:extern} Res_VALID_REGION(int) : int;

function {:extern} Equal([int]bool, [int]bool) : bool;

function {:extern} Subset([int]bool, [int]bool) : bool;

function {:extern} Disjoint([int]bool, [int]bool) : bool;

function {:extern} Empty() : [int]bool;

function {:extern} SetTrue() : [int]bool;

function {:extern} Singleton(int) : [int]bool;

function {:extern} Reachable([int,int]bool, int) : [int]bool;

function {:extern} Union([int]bool, [int]bool) : [int]bool;

function {:extern} Intersection([int]bool, [int]bool) : [int]bool;

function {:extern} Difference([int]bool, [int]bool) : [int]bool;

function {:extern} Dereference([int]bool, [int]int) : [int]bool;

function {:extern} Inverse(f: [int]int, x: int) : [int]bool;

function {:extern} AtLeast(int, int) : [int]bool;

function {:extern} Rep(int, int) : int;

axiom (forall n: int, x: int, y: int :: { AtLeast(n, x)[y] } AtLeast(n, x)[y] ==> INT_LEQ(x, y) && Rep(n, x) == Rep(n, y));

axiom (forall n: int, x: int, y: int :: { AtLeast(n, x), Rep(n, x), Rep(n, y) } INT_LEQ(x, y) && Rep(n, x) == Rep(n, y) ==> AtLeast(n, x)[y]);

axiom (forall n: int, x: int :: { AtLeast(n, x) } AtLeast(n, x)[x]);

axiom (forall n: int, x: int, z: int :: { INT_PLUS(x, n, z) } Rep(n, x) == Rep(n, INT_PLUS(x, n, z)));

axiom (forall n: int, x: int :: { Rep(n, x) } (exists k: int :: INT_SUB(Rep(n, x), x) == INT_MULT(n, k)));

function {:extern} Array(int, int, int) : [int]bool;

axiom (forall x: int, n: int, z: int :: { Array(x, n, z) } INT_LEQ(z, 0) ==> Equal(Array(x, n, z), Empty()));

axiom (forall x: int, n: int, z: int :: { Array(x, n, z) } INT_GT(z, 0) ==> Equal(Array(x, n, z), Difference(AtLeast(n, x), AtLeast(n, INT_PLUS(x, n, z)))));

axiom (forall x: int :: !Empty()[x]);

axiom (forall x: int :: SetTrue()[x]);

axiom (forall x: int, y: int :: { Singleton(y)[x] } Singleton(y)[x] <==> x == y);

axiom (forall y: int :: { Singleton(y) } Singleton(y)[y]);

axiom (forall x: int, S: [int]bool, T: [int]bool :: { Union(S, T)[x] } { Union(S, T), S[x] } { Union(S, T), T[x] } Union(S, T)[x] <==> S[x] || T[x]);

axiom (forall x: int, S: [int]bool, T: [int]bool :: { Intersection(S, T)[x] } { Intersection(S, T), S[x] } { Intersection(S, T), T[x] } Intersection(S, T)[x] <==> S[x] && T[x]);

axiom (forall x: int, S: [int]bool, T: [int]bool :: { Difference(S, T)[x] } { Difference(S, T), S[x] } { Difference(S, T), T[x] } Difference(S, T)[x] <==> S[x] && !T[x]);

axiom (forall S: [int]bool, T: [int]bool :: { Equal(S, T) } Equal(S, T) <==> Subset(S, T) && Subset(T, S));

axiom (forall x: int, S: [int]bool, T: [int]bool :: { S[x], Subset(S, T) } { T[x], Subset(S, T) } S[x] && Subset(S, T) ==> T[x]);

axiom (forall S: [int]bool, T: [int]bool :: { Subset(S, T) } Subset(S, T) || (exists x: int :: S[x] && !T[x]));

axiom (forall x: int, S: [int]bool, T: [int]bool :: { S[x], Disjoint(S, T) } { T[x], Disjoint(S, T) } !(S[x] && Disjoint(S, T) && T[x]));

axiom (forall S: [int]bool, T: [int]bool :: { Disjoint(S, T) } Disjoint(S, T) || (exists x: int :: S[x] && T[x]));

axiom (forall f: [int]int, x: int :: { Inverse(f, f[x]) } Inverse(f, f[x])[x]);

axiom (forall f: [int]int, x: int, y: int :: { Inverse(f, y), f[x] } Inverse(f, y)[x] ==> f[x] == y);

axiom (forall f: [int]int, x: int, y: int :: { Inverse(f[x := y], y) } Equal(Inverse(f[x := y], y), Union(Inverse(f, y), Singleton(x))));

axiom (forall f: [int]int, x: int, y: int, z: int :: { Inverse(f[x := y], z) } y == z || Equal(Inverse(f[x := y], z), Difference(Inverse(f, z), Singleton(x))));

axiom (forall x: int, S: [int]bool, M: [int]int :: { Dereference(S, M)[x] } Dereference(S, M)[x] ==> (exists y: int :: x == M[y] && S[y]));

axiom (forall x: int, S: [int]bool, M: [int]int :: { M[x], S[x], Dereference(S, M) } S[x] ==> Dereference(S, M)[M[x]]);

axiom (forall x: int, y: int, S: [int]bool, M: [int]int :: { Dereference(S, M[x := y]) } !S[x] ==> Equal(Dereference(S, M[x := y]), Dereference(S, M)));

axiom (forall x: int, y: int, S: [int]bool, M: [int]int :: { Dereference(S, M[x := y]) } S[x] && Equal(Intersection(Inverse(M, M[x]), S), Singleton(x)) ==> Equal(Dereference(S, M[x := y]), Union(Difference(Dereference(S, M), Singleton(M[x])), Singleton(y))));

axiom (forall x: int, y: int, S: [int]bool, M: [int]int :: { Dereference(S, M[x := y]) } S[x] && !Equal(Intersection(Inverse(M, M[x]), S), Singleton(x)) ==> Equal(Dereference(S, M[x := y]), Union(Dereference(S, M), Singleton(y))));

function {:extern} Unified([name][int]int) : [int]int;

axiom (forall M: [name][int]int, x: int :: { Unified(M)[x] } Unified(M)[x] == M[Field(x)][x]);

axiom (forall M: [name][int]int, x: int, y: int :: { Unified(M[Field(x) := M[Field(x)][x := y]]) } Unified(M[Field(x) := M[Field(x)][x := y]]) == Unified(M)[x := y]);

const {:extern} unique global1: int;

axiom INT_GT(global1, 0);

axiom Base(global1) == global1;

const {:extern} unique global2: int;

axiom INT_GT(global2, 0);

axiom Base(global2) == global2;

const {:extern} unique global3: int;

axiom INT_GT(global3, 0);

axiom Base(global3) == global3;

const {:extern} unique global4: int;

axiom INT_GT(global4, 0);

axiom Base(global4) == global4;

const {:extern} unique global5: int;

axiom INT_GT(global5, 0);

axiom Base(global5) == global5;

const {:extern} unique BOOGIE_FLOAT_CONST_0: int;

function {:extern} value_is(c: int, e: int) : bool;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 48} unique __ctobpl_const_12: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 49} unique __ctobpl_const_14: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 49} unique __ctobpl_const_13: int;

const {:extern} {:model_const "result.TestGlobalRecursion"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 49} unique __ctobpl_const_15: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 54} unique __ctobpl_const_16: int;

const {:extern} {:model_const "z"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 64} unique __ctobpl_const_20: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 56} unique __ctobpl_const_18: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 56} unique __ctobpl_const_17: int;

const {:extern} {:model_const "result.TestRecursion"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 56} unique __ctobpl_const_19: int;

const {:extern} {:model_const "result.TestEmptyRecursion"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 42} unique __ctobpl_const_10: int;

const {:extern} {:model_const "global2"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 48} unique __ctobpl_const_11: int;

const {:extern} {:model_const "w"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 18} unique __ctobpl_const_3: int;

const {:extern} {:model_const "y"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 24} unique __ctobpl_const_4: int;

const {:extern} {:model_const "w"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 27} unique __ctobpl_const_5: int;

const {:extern} {:model_const "y"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 15} unique __ctobpl_const_2: int;

const {:extern} {:model_const "global1"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 9} unique __ctobpl_const_1: int;

const {:extern} {:model_const "w"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 25} unique __ctobpl_const_6: int;

const {:extern} {:model_const "result.TestCallDominationDependancyCalleeConst"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 25} unique __ctobpl_const_7: int;

const {:extern} {:model_const "y"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 72} unique __ctobpl_const_25: int;

const {:extern} {:model_const "global3"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 73} unique __ctobpl_const_26: int;

const {:extern} {:model_const "global5"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 71} unique __ctobpl_const_23: int;

const {:extern} {:model_const "w"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 67} unique __ctobpl_const_24: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 32} unique __ctobpl_const_27: int;

const {:extern} {:model_const "w"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 37} unique __ctobpl_const_30: int;

const {:extern} {:model_const "global4"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 65} unique __ctobpl_const_21: int;

const {:extern} {:model_const "z"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 34} unique __ctobpl_const_32: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 66} unique __ctobpl_const_22: int;

const {:extern} {:model_const "w"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 35} unique __ctobpl_const_33: int;

const {:extern} {:model_const "y"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 32} unique __ctobpl_const_28: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 34} unique __ctobpl_const_31: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 33} unique __ctobpl_const_29: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 42} unique __ctobpl_const_8: int;

const {:extern} {:model_const "x"} {:sourceFile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceLine 42} unique __ctobpl_const_9: int;

procedure {:extern} TestCallDominationDependancyCalleeConst() returns (result.TestCallDominationDependancyCalleeConst$1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestCallDominationDependancyCalleeConst() returns (result.TestCallDominationDependancyCalleeConst$1: int)
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    result.TestCallDominationDependancyCalleeConst$1 := 0;
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 3} true;
    result.TestCallDominationDependancyCalleeConst$1 := 0;
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 4} true;
    return;
}



procedure {:extern} TestCallDominationDependancyCalleeGlobals();
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestCallDominationDependancyCalleeGlobals()
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 9} true;
    assume value_is(__ctobpl_const_1, Mem_T.INT4[global1]);
    tempBoogie0 := INT_PLUS(Mem_T.INT4[global1], 1, 1);
    Mem_T.INT4 := Mem_T.INT4[global1 := tempBoogie0];
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 10} true;
    return;
}



procedure {:extern} TestCallDominationDependancyGlobals(y_.1: int, z_.1: int) returns (result.TestCallDominationDependancyGlobals$1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestCallDominationDependancyGlobals(y_.1: int, z_.1: int) returns (result.TestCallDominationDependancyGlobals$1: int)
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} w: int;
  var {:extern} y: int;
  var {:extern} z: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    result.TestCallDominationDependancyGlobals$1 := 0;
    w := 0;
    y := 0;
    z := 0;
    y := y_.1;
    z := z_.1;
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 14} true;
    goto label_4#2;

  label_4#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 15} true;
    goto label_4_true#2, label_4_false#2;

  label_4_false#2:
    assume y == 0;
    assume value_is(__ctobpl_const_2, y);
    goto label_5#2;

  label_4_true#2:
    assume y != 0;
    assume value_is(__ctobpl_const_2, y);
    goto label_6#2;

  label_6#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 16} true;
    call TestCallDominationDependancyCalleeGlobals();
    goto label_5#2;

  label_5#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 18} true;
    result.TestCallDominationDependancyGlobals$1 := w;
    assume value_is(__ctobpl_const_3, w);
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 19} true;
    return;
}



procedure {:extern} TestCallDominationDependancyReturns(y_.1: int, z_.1: int) returns (result.TestCallDominationDependancyReturns$1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestCallDominationDependancyReturns(y_.1: int, z_.1: int) returns (result.TestCallDominationDependancyReturns$1: int)
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} result.TestCallDominationDependancyCalleeConst$2: int;
  var {:extern} w: int;
  var {:extern} y: int;
  var {:extern} z: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    result.TestCallDominationDependancyCalleeConst$2 := 0;
    result.TestCallDominationDependancyReturns$1 := 0;
    w := 0;
    y := 0;
    z := 0;
    y := y_.1;
    z := z_.1;
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 23} true;
    goto label_4#2;

  label_4#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 24} true;
    goto label_4_true#2, label_4_false#2;

  label_4_false#2:
    assume y == 0;
    assume value_is(__ctobpl_const_4, y);
    goto label_5#2;

  label_4_true#2:
    assume y != 0;
    assume value_is(__ctobpl_const_4, y);
    goto label_6#2;

  label_6#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 25} true;
    call result.TestCallDominationDependancyCalleeConst$2 := TestCallDominationDependancyCalleeConst();
    goto label_9#2;

  label_9#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 25} true;
    w := result.TestCallDominationDependancyCalleeConst$2;
    assume value_is(__ctobpl_const_6, w);
    assume value_is(__ctobpl_const_7, result.TestCallDominationDependancyCalleeConst$2);
    goto label_5#2;

  label_5#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 27} true;
    result.TestCallDominationDependancyReturns$1 := w;
    assume value_is(__ctobpl_const_5, w);
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 28} true;
    return;
}



procedure {:extern} TestEmptyRecursion(x_.1: int) returns (result.TestEmptyRecursion$1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestEmptyRecursion(x_.1: int) returns (result.TestEmptyRecursion$1: int)
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} result.TestEmptyRecursion$2: int;
  var {:extern} x: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    result.TestEmptyRecursion$1 := 0;
    result.TestEmptyRecursion$2 := 0;
    x := 0;
    x := x_.1;
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 42} true;
    call result.TestEmptyRecursion$2 := TestEmptyRecursion(x);
    assume value_is(__ctobpl_const_8, x);
    assume value_is(__ctobpl_const_9, x);
    goto label_6#2;

  label_6#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 42} true;
    result.TestEmptyRecursion$1 := result.TestEmptyRecursion$2;
    assume value_is(__ctobpl_const_10, result.TestEmptyRecursion$2);
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 43} true;
    return;
}



procedure {:extern} TestGlobalRecursion(x_.1: int) returns (result.TestGlobalRecursion$1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestGlobalRecursion(x_.1: int) returns (result.TestGlobalRecursion$1: int)
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} result.TestGlobalRecursion$2: int;
  var {:extern} x: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    result.TestGlobalRecursion$1 := 0;
    result.TestGlobalRecursion$2 := 0;
    x := 0;
    x := x_.1;
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 48} true;
    tempBoogie0 := INT_PLUS(Mem_T.INT4[global2], 1, x);
    Mem_T.INT4 := Mem_T.INT4[global2 := tempBoogie0];
    assume value_is(__ctobpl_const_11, Mem_T.INT4[global2]);
    assume value_is(__ctobpl_const_12, x);
    goto label_4#2;

  label_4#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 49} true;
    call result.TestGlobalRecursion$2 := TestGlobalRecursion(x);
    assume value_is(__ctobpl_const_13, x);
    assume value_is(__ctobpl_const_14, x);
    goto label_7#2;

  label_7#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 49} true;
    result.TestGlobalRecursion$1 := result.TestGlobalRecursion$2;
    assume value_is(__ctobpl_const_15, result.TestGlobalRecursion$2);
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 50} true;
    return;
}



procedure {:extern} TestRecursion(x_.1: int) returns (result.TestRecursion$1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestRecursion(x_.1: int) returns (result.TestRecursion$1: int)
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} result.TestRecursion$2: int;
  var {:extern} x: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    result.TestRecursion$1 := 0;
    result.TestRecursion$2 := 0;
    x := 0;
    x := x_.1;
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 54} true;
    goto label_3_true#2, label_3_false#2;

  label_3_false#2:
    assume !INT_LT(x, 0);
    assume value_is(__ctobpl_const_16, x);
    goto label_4#2;

  label_4#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 56} true;
    call result.TestRecursion$2 := TestRecursion(x);
    assume value_is(__ctobpl_const_17, x);
    assume value_is(__ctobpl_const_18, x);
    goto label_8#2;

  label_8#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 56} true;
    result.TestRecursion$1 := result.TestRecursion$2;
    assume value_is(__ctobpl_const_19, result.TestRecursion$2);
    goto label_1#2;

  label_3_true#2:
    assume INT_LT(x, 0);
    assume value_is(__ctobpl_const_16, x);
    goto label_7#2;

  label_7#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 55} true;
    result.TestRecursion$1 := 0;
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 57} true;
    return;
}



procedure {:extern} TestReturnDomination(x_.1: int, w_.1: int) returns (result.TestReturnDomination$1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestReturnDomination(x_.1: int, w_.1: int) returns (result.TestReturnDomination$1: int)
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} p: int;
  var {:extern} w: int;
  var {:extern} x: int;
  var {:extern} y: int;
  var {:extern} z: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    p := 0;
    result.TestReturnDomination$1 := 0;
    w := 0;
    x := 0;
    y := 0;
    z := 0;
    x := x_.1;
    w := w_.1;
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 63} true;
    goto label_4#2;

  label_4#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 63} true;
    goto label_5#2;

  label_5#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 63} true;
    goto label_6#2;

  label_6#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 64} true;
    assume value_is(__ctobpl_const_20, z);
    z := INT_PLUS(z, 1, 1);
    goto label_7#2;

  label_7#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 65} true;
    assume value_is(__ctobpl_const_21, Mem_T.INT4[global4]);
    tempBoogie0 := INT_PLUS(Mem_T.INT4[global4], 1, 1);
    Mem_T.INT4 := Mem_T.INT4[global4 := tempBoogie0];
    goto label_8#2;

  label_8#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 66} true;
    goto label_8_true#2, label_8_false#2;

  label_8_false#2:
    assume !INT_LT(0, x);
    assume value_is(__ctobpl_const_22, x);
    goto label_9#2;

  label_9#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 71} true;
    assume value_is(__ctobpl_const_23, Mem_T.CHAR[global5]);
    tempBoogie0 := INT_PLUS(Mem_T.CHAR[global5], 1, 1);
    Mem_T.CHAR := Mem_T.CHAR[global5 := tempBoogie0];
    goto label_11#2;

  label_8_true#2:
    assume INT_LT(0, x);
    assume value_is(__ctobpl_const_22, x);
    goto label_10#2;

  label_10#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 67} true;
    goto label_10_true#2, label_10_false#2;

  label_10_false#2:
    assume !INT_LT(0, w);
    assume value_is(__ctobpl_const_24, w);
    goto label_11#2;

  label_11#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 72} true;
    assume value_is(__ctobpl_const_25, y);
    y := INT_PLUS(y, 1, 1);
    goto label_13#2;

  label_13#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 73} true;
    Mem_T.FLOAT := Mem_T.FLOAT[global3 := 0];
    assume value_is(__ctobpl_const_26, Mem_T.FLOAT[global3]);
    goto label_14#2;

  label_14#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 74} true;
    result.TestReturnDomination$1 := 2;
    goto label_1#2;

  label_10_true#2:
    assume INT_LT(0, w);
    assume value_is(__ctobpl_const_24, w);
    goto label_12#2;

  label_12#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 68} true;
    result.TestReturnDomination$1 := 0;
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 75} true;
    return;
}



procedure {:extern} TestSimpleDominationDependancy(y_.1: int, z_.1: int) returns (result.TestSimpleDominationDependancy$1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, detChoiceCnt, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.CHAR, Mem_T.FLOAT, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_KERNEL_SOURCE[_r] } old(Res_KERNEL_SOURCE)[_r] == Res_KERNEL_SOURCE[_r]);
  free ensures old(Res_KERNEL_SOURCE) == Res_KERNEL_SOURCE;
  ensures Subset(Empty(), Empty()) && (forall _r: int :: { Res_PROBED[_r] } old(Res_PROBED)[_r] == Res_PROBED[_r]);
  free ensures old(Res_PROBED) == Res_PROBED;
  free ensures Mem_T.CHAR == old(Mem_T.CHAR);
  free ensures Mem_T.FLOAT == old(Mem_T.FLOAT);
  free ensures Mem_T.INT4 == old(Mem_T.INT4);



implementation {:extern} TestSimpleDominationDependancy(y_.1: int, z_.1: int) returns (result.TestSimpleDominationDependancy$1: int)
{
  var {:extern} havoc_stringTemp: int;
  var {:extern} condVal: int;
  var {:extern} w: int;
  var {:extern} x: int;
  var {:extern} y: int;
  var {:extern} z: int;
  var {:extern} tempBoogie0: int;
  var {:extern} tempBoogie1: int;
  var {:extern} tempBoogie2: int;
  var {:extern} tempBoogie3: int;
  var {:extern} tempBoogie4: int;
  var {:extern} tempBoogie5: int;
  var {:extern} tempBoogie6: int;
  var {:extern} tempBoogie7: int;
  var {:extern} tempBoogie8: int;
  var {:extern} tempBoogie9: int;
  var {:extern} tempBoogie10: int;
  var {:extern} tempBoogie11: int;
  var {:extern} tempBoogie12: int;
  var {:extern} tempBoogie13: int;
  var {:extern} tempBoogie14: int;
  var {:extern} tempBoogie15: int;
  var {:extern} tempBoogie16: int;
  var {:extern} tempBoogie17: int;
  var {:extern} tempBoogie18: int;
  var {:extern} tempBoogie19: int;
  var {:extern} __havoc_dummy_return: int;

  anon0#2:
    havoc_stringTemp := 0;
    goto start#2;

  start#2:
    result.TestSimpleDominationDependancy$1 := 0;
    w := 0;
    x := 0;
    y := 0;
    z := 0;
    y := y_.1;
    z := z_.1;
    goto label_3#2;

  label_3#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 32} true;
    goto label_4#2;

  label_4#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 32} true;
    x := INT_PLUS(y, 1, 1);
    assume value_is(__ctobpl_const_27, x);
    assume value_is(__ctobpl_const_28, y);
    goto label_5#2;

  label_5#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 32} true;
    goto label_6#2;

  label_6#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 33} true;
    goto label_6_true#2, label_6_false#2;

  label_6_false#2:
    assume x == 0;
    assume value_is(__ctobpl_const_29, x);
    goto label_7#2;

  label_6_true#2:
    assume x != 0;
    assume value_is(__ctobpl_const_29, x);
    goto label_8#2;

  label_8#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 34} true;
    x := z;
    assume value_is(__ctobpl_const_31, x);
    assume value_is(__ctobpl_const_32, z);
    goto label_9#2;

  label_9#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 35} true;
    w := 2;
    assume value_is(__ctobpl_const_33, w);
    goto label_7#2;

  label_7#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 37} true;
    result.TestSimpleDominationDependancy$1 := w;
    assume value_is(__ctobpl_const_30, w);
    goto label_1#2;

  label_1#2:
    assert {:sourcefile "c:\users\t-nisebb\documents\symdiff.src\dependency\test\simple_examples\simple1\v1\foo.c"} {:sourceline 38} true;
    return;
}


