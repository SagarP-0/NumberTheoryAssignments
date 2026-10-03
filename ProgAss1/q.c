//CS26BTKMU11003
//extended euclidian algo
// to run just 
// >> gcc -o q q.c -lgmp && ./q

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <gmp.h>

//input file defined in the same folder
#define INPUT_FILE "ip.csv"

//defining extended eculids gcd function, although it is also available in the gmp libaray as  >> mpz_gcdext(g, x, y, a, b);
void ee_gcd(mpz_t g, mpz_t x, mpz_t y, const mpz_t a, const mpz_t b)
{
    mpz_t old_r, r, old_s, s, old_t, t, q, tmp;
    mpz_inits(old_r, r, old_s, s, old_t, t, q, tmp, NULL);
 
    /* initialize: (old_r, r) = (a, b), (old_s, s) = (1, 0), (old_t, t) = (0, 1) */
    mpz_set(old_r, a);
    mpz_set(r, b);
    mpz_set_ui(old_s, 1);
    mpz_set_ui(s, 0);
    mpz_set_ui(old_t, 0);
    mpz_set_ui(t, 1);
 
    while (mpz_sgn(r) != 0) {
        /* q = old_r / r  (truncating division; safe since values stay >= 0) */
        mpz_tdiv_q(q, old_r, r);
 
        /* update r: (old_r, r) = (r, old_r - q*r) */
        mpz_mul(tmp, q, r);
        mpz_sub(tmp, old_r, tmp);
        mpz_set(old_r, r);
        mpz_set(r, tmp);
 
        /* update s: (old_s, s) = (s, old_s - q*s) */
        mpz_mul(tmp, q, s);
        mpz_sub(tmp, old_s, tmp);
        mpz_set(old_s, s);
        mpz_set(s, tmp);
 
        /* update t: (old_t, t) = (t, old_t - q*t) */
        mpz_mul(tmp, q, t);
        mpz_sub(tmp, old_t, tmp);
        mpz_set(old_t, t);
        mpz_set(t, tmp);
    }
 
    /* old_r is now gcd(a,b); old_s, old_t are the Bezout coefficients */
    mpz_set(g, old_r);
    mpz_set(x, old_s);
    mpz_set(y, old_t);
 
    mpz_clears(old_r, r, old_s, s, old_t, t, q, tmp, NULL);
}

int main(void)
{
    //file existence check
    FILE *fp = fopen(INPUT_FILE, "r");
    if (!fp) {
        fprintf(stderr, "Error: could not open input file '%s'\n", INPUT_FILE);
        return 1;
    }

    mpz_t a, b, g, x, y;
    mpz_inits(a, b, g, x, y, NULL);

    char *line = NULL;
    size_t cap = 0;
    size_t len;

    printf("\nOutput displayed for GMPs inbuilt gcd function and UserDefined function(must be same):\n");

    while ((len = getline(&line, &cap, fp)) != -1) {
        
        //reading csv file
        while (len > 0 && (line[len - 1] == '\n' || line[len - 1] == '\r')) {
            line[--len] = '\0';
        }
        if (len == 0) continue;               

        //extracting data from csv
        char *comma = strchr(line, ',');
        if (!comma) continue;               
        *comma = '\0';
        char *a_str = line;
        char *b_str = comma + 1;

        /* trimming data, whitespaces and such in csv file */
        while (*a_str == ' ' || *a_str == '\t') a_str++;
        while (*b_str == ' ' || *b_str == '\t') b_str++;
        char *end;
        end = a_str + strlen(a_str);
        while (end > a_str && (end[-1] == ' ' || end[-1] == '\t')) *(--end) = '\0';
        end = b_str + strlen(b_str);
        while (end > b_str && (end[-1] == ' ' || end[-1] == '\t')) *(--end) = '\0';

        if (*a_str == '\0' || *b_str == '\0') continue;

        ///parsing data
        if (mpz_set_str(a, a_str, 10) != 0) continue;
        if (mpz_set_str(b, b_str, 10) != 0) continue;

        /* extended gcd: g = gcd(a,b) = a*x + b*y */
        printf("\nGMPS prebuilt function:\n");
        mpz_gcdext(g, x, y, a, b);
        gmp_printf("x=%Zd,y=%Zd,c=%Zd\n", x, y, g);

        /* our ee_gcd function*/
        printf("\nSelf defined function:\n");
        ee_gcd(g, x, y, a, b);
        gmp_printf("x=%Zd,y=%Zd,c=%Zd\n", x, y, g);

    }

    free(line);
    fclose(fp);
    mpz_clears(a, b, g, x, y, NULL);

    return 0;
}
