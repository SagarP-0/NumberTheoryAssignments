# Factor a quadratic polynomial over Z_p  (run with:  sage factor_quadratic.sage)
#
# Algorithm:
#   1. Complete the square:  a x^2 + b x + c = a((x+h)^2 - t),  h = b/(2a),
#      t = h^2 - c/a   (p odd).
#   2. t must be a square mod p (Euler's criterion), otherwise f is irreducible.
#   3. Factor y^2 - t by the equal-degree (Cantor-Zassenhaus) idea:
#      pick random s, compute (y+s)^((p-1)/2) mod (y^2 - t), take
#      gcd(that - 1, y^2 - t); a degree-1 gcd gives a root.
#   4. Substitute y = x + h back.


# Subroutine: f(x)^t mod g(x) (square and multiply)
def poly_powmod(f, t, g):
    """Return f^t mod g, using repeated squaring (t >= 0 an integer)."""
    P = g.parent()
    result = P(1)
    base = f % g
    while t > 0:
        if t % 2 == 1:
            result = (result * base) % g
        base = (base * base) % g
        t = t // 2
    return result


#  Subroutine: is t a square mod p?
def is_square_mod_p(t, p):
    """True iff t is a square mod the prime p (Euler's criterion)."""
    t = Integer(t) % p
    if t == 0 or p == 2:
        return True
    return pow(t, (p - 1) // 2, p) == 1


# Subroutine: factor y^2 - t
def factor_x2_minus_t(t, p):
    """Return r such that y^2 - t = (y - r)(y + r) mod p, or None if t is
    not a square mod p."""
    t = Integer(t) % p
    if not is_square_mod_p(t, p):
        return None
    if t == 0:
        return Integer(0)
    if p == 2:                       # t = 1: y^2 - 1 = (y - 1)^2 mod 2
        return Integer(1)
    R = PolynomialRing(GF(p), 'y')
    y = R.gen()
    g = y^2 - t
    while True:
        s = randint(0, p - 1)
        h = poly_powmod(y + s, (p - 1) // 2, g)
        d = gcd(h - 1, g)
        if d.degree() == 1:
            d = d.monic()            # d = y - r
            return Integer(-d[0])
        # if d is 1 or g (degree 0 or 2), try another s


# Main factoring routine
def factor_quadratic(f, p):
    """Return None if f is irreducible, else (a, r1, r2) with
    f = a (x - r1)(x - r2) in Z_p[x]."""
    F = GF(p)
    a, b, c = F(f[2]), F(f[1]), F(f[0])
    if p == 2:                       # no division by 2: just test x = 0, 1
        roots = [r for r in (0, 1) if f(F(r)) == 0]
        if len(roots) == 0:
            return None
        if len(roots) == 1:
            return (a, F(roots[0]), F(roots[0]))
        return (a, F(0), F(1))
    h = b / (2 * a)
    t = h^2 - c / a
    r = factor_x2_minus_t(Integer(t), p)
    if r is None:
        return None
    r = F(r)
    # (x + h)^2 - t = (x + h - r)(x + h + r)
    return (a, -(h - r), -(h + r))


# Input handling with validity checks
def read_input():
    p = Integer(input("Enter the prime p: "))
    if not p.is_prime():
        print("Invalid input: p is not prime.")
        return None
    s = input("Enter the quadratic polynomial: ")
    s = s.replace('−', '-').replace('∗', '*').replace('×', '*')
    R = PolynomialRing(GF(p), 'x')
    x = R.gen()
    try:
        f = R(sage_eval(s, locals={'x': x}))
    except Exception:
        print("Invalid input: could not parse the polynomial.")
        return None
    if f == 0 or f.degree() > 2:
        print("Invalid input: the polynomial must be nonzero with degree at most 2.")
        return None
    return p, f


def show(p, f):
    if f.degree() < 2:
        print("The polynomial has degree", f.degree(), "; it is already a factor itself:", f)
        return
    res = factor_quadratic(f, p)
    if res is None:
        print("The given polynomial is irreducible.")
        return
    a, r1, r2 = res
    # factor (x - r) printed as (x + (-r mod p)), smaller constant first
    c1, c2 = sorted([Integer(-r1), Integer(-r2)])
    out = ""
    if a != 1:
        out += str(Integer(a)) + " * "
    out += "(x + %s) * (x + %s)" % (c1, c2)
    print("The factorization is: " + out + ".")


# Tests for the subroutines
def run_tests():
    # poly_powmod: compare with Sage's built-in power-then-reduce
    for p in [3, 5, 7, 11]:
        R = PolynomialRing(GF(p), 'x'); x = R.gen()
        g = x^2 + 1
        for f in [x + 1, 2*x + 3, x^2 + x]:
            for t in range(0, 8):
                assert poly_powmod(f, t, g) == (f^t) % g
    # is_square_mod_p
    for p in [3, 5, 7, 11, 13]:
        squares = set((k*k) % p for k in range(p))
        for t in range(p):
            assert is_square_mod_p(t, p) == (t in squares)
    # factor_x2_minus_t
    for p in [3, 5, 7, 11, 13, 41]:
        for t in range(p):
            r = factor_x2_minus_t(t, p)
            if is_square_mod_p(t, p):
                assert (r * r - t) % p == 0
            else:
                assert r is None
    print("All subroutine tests passed.")


if __name__ == "__main__" or True:
    run_tests()
    data = read_input()
    if data is not None:
        p, f = data
        show(p, f)
