#please check github for exection or see outputs in the readme section
#github: https://github.com/SagarP-0/NumberTheoryAssignments
# Cantor-Zassenhaus factorization over F_p: square-free check, DDF, EDF

def powmod(a, e, m):
    r = a.parent()(1)
    a = a % m
    while e > 0:
        if e & 1:
            r = r * a % m
        a = a * a % m
        e >>= 1
    return r


def stage1(f):
    g = gcd(f, f.derivative())
    return g, g.degree() == 0


def stage2(f, p):
    x = f.parent().gen()
    parts = []
    g, h, i = f, x, 0
    while g.degree() >= 2 * (i + 1):
        i += 1
        h = powmod(h, p, g)          # x^(p^i) mod g
        c = gcd(g, h - x)
        if c.degree() > 0:
            parts.append((i, c))
            g = g // c
            h = h % g
    if g.degree() > 0:               # no factor of degree <= i, so irreducible
        parts.append((g.degree(), g))
    return parts


def split(v, r, p):
    R = v.parent()
    n = v.degree()
    while True:
        a = R.random_element(degree=(0, n - 1))
        g = gcd(a, v)
        if g.degree() == 0:
            if p == 2:
                t = s = a % v
                for _ in range(r - 1):
                    s = s * s % v
                    t = t + s
                g = gcd(t % v, v)
            else:
                b = powmod(a, (p**r - 1) // 2, v)
                g = gcd(b - 1, v)
        if 0 < g.degree() < n:
            return g


def edf(v, r, p):
    if v.degree() == r:
        return [v]
    g = split(v, r, p)
    return edf(g, r, p) + edf(v // g, r, p)


def stage3(parts, p):
    return [(r, edf(c, r, p)) for r, c in parts]


def is_irred(f, p):
    x = f.parent().gen()
    n = f.degree()
    if powmod_frob(x, n, p, f) != x % f:
        return False
    for q in prime_divisors(n):
        h = powmod_frob(x, n // q, p, f)
        if gcd(h - x, f).degree() > 0:
            return False
    return True


def powmod_frob(x, k, p, f):
    h = x % f
    for _ in range(k):
        h = powmod(h, p, f)
    return h


def run(p, fs):
    if not Integer(p).is_prime():
        print("p must be prime"); return
    R = PolynomialRing(GF(p), 'x')
    x = R.gen()
    try:
        f = R(sage_eval(fs, locals={'x': x}))
    except Exception:
        print("could not parse f"); return
    d = f.degree()
    if d < 1 or d > 50 or not f.is_monic():
        print("f must be monic with 1 <= degree <= 50"); return

    print("Stage 1: square-free verification")
    g, sf = stage1(f)
    print("  gcd(f, f') =", g)
    print("  square-free:", sf)
    if not sf:
        print("  input is not square-free"); return
    print("  passed to stage 2:", f)

    print("Stage 2: distinct-degree factorization")
    parts = stage2(f, p)
    for r, c in parts:
        print("  degree %d: %s" % (r, c))

    print("Stage 3: equal-degree factorization")
    groups = stage3(parts, p)
    for r, fl in groups:
        print("  degree %d:" % r)
        for q in fl:
            print("    ", q)

    facs = [q for _, fl in groups for q in fl]
    print("Final factorization:")
    if len(facs) == 1:
        print("  f is irreducible")
    else:
        print("  " + " * ".join("(%s)" % q for q in facs))
    return f, parts, groups


def main():
    p = Integer(input("Enter the prime p: "))
    input("Enter the degree d: ")
    fs = input("Enter the polynomial f: ").replace('−', '-')
    run(p, fs)


if 'NO_MAIN' not in globals():
    main()
