NO_MAIN = True
load('cz.sage')

samples = [
    (987013, "x^10 + 987010*x^8 + 987009*x^7 + 7*x^5 + 9*x^4 + 8*x^3 + 987009*x^2 + 986999*x + 987007"),
    (987013, "x^24 + 90470*x^23 + 584910*x^22 + 424214*x^21 + 617809*x^20 + 564069*x^19 + 498745*x^18 + 585592*x^17 + 948174*x^16 + 401092*x^15 + 969584*x^14 + 205925*x^13 + 227787*x^12 + 799739*x^11 + 79152*x^10 + 206275*x^9 + 615771*x^8 + 297793*x^7 + 804341*x^6 + 601340*x^5 + 352012*x^4 + 44059*x^3 + 265844*x^2 + 982273*x + 805981"),
    (987013, "x^18 + 63433*x^17 + 976930*x^16 + 820322*x^15 + 964786*x^14 + 792610*x^13 + 63903*x^12 + 121839*x^11 + 310997*x^10 + 431335*x^9 + 63915*x^8 + 258752*x^7 + 129005*x^6 + 375003*x^5 + 203701*x^4 + 235473*x^3 + 669490*x^2 + 849285*x + 565324"),
]


def check(p, f, parts, groups):
    prod = lambda l: prod_list(l)
    assert prod_list([c for _, c in parts]) == f
    for (r, c), (r2, fl) in zip(parts, groups):
        assert r == r2 and prod_list(fl) == c
        assert all(q.degree() == r and q.is_monic() and is_irred(q, p) for q in fl)
    assert prod_list([q for _, fl in groups for q in fl]) == f
    print("  checks passed: products, degrees, monic, Rabin irreducibility")


def prod_list(l):
    r = l[0].parent()(1)
    for q in l:
        r *= q
    return r


for k, (p, fs) in enumerate(samples, 1):
    print("=== Sample %d ===" % k)
    f, parts, groups = run(p, fs)
    check(p, f, parts, groups)


#extra stuff for unsual test cases, uncomment to check 
# extra: characteristic 2, irreducible input, non-square-free, bad input
#print("=== p = 2 ===")
#R2 = PolynomialRing(GF(2), 'x'); x2 = R2.gen()
#f2, parts, groups = run(2, "(x^2+x+1)*(x^3+x+1)*(x^3+x^2+1)*(x^5+x^2+1)*(x^4+x+1)")
#check(2, f2, parts, groups)
#print("=== irreducible ===")
#run(603319, "x^2 - 117725")
#run(2, "x^5 + x^2 + 1")
#run(3, "x^7 + 2*x + 1")
#print("=== non-square-free ===")
#run(7, "(x+1)^2*(x+3)")
#print("=== invalid ===")
#run(9, "x^2+1")
#run(7, "2*x^2+1")
