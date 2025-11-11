#include <stdio.h>
#include <stdlib.h>

// global: days since 1/1/1970
int DAYS_SINCE_1970 = 0;

// struct containing date info
typedef struct {
    int day;  // current day in this year
    int year; // current year
} yearday_t;

// Layout of yearday_t in memory and
// as a packed register argument.
//
// | Field | Size | Offset | Bits |
// |-------+------+--------+--------|
// | day   | 4    | +0     | 0-31  |
// | year  | 4    | +4     | 32-63 |

int setday(yearday_t yd);
// DEFINED IN ASSEMBLY
//
// Extracts the day and year fields
// from the provided struct yd. If day is
// negative or year is < 1970, sets the
// global variable DAYS_SINCE_1970 to
// be -1 and returns 1. Otherwise
// computes the number of days since
// 1970 based on these fields assuming
// NO LEAP YEARS and 365 days per
// year. Sets the global variable
// DAYS_SINCE_1970 to this value and
// returns 0.

int main(int argc, char *argv[]) {
    // Demonstrate 3 examples of setday()
    int ret;

    yearday_t yd1 = { .day = 20, .year = 1970 };
    ret = setday(yd1);
    printf("%3d days since 1970 (ret: %d)\n", DAYS_SINCE_1970, ret);
    // 20 days since 1970 (ret: 0)

    yearday_t yd2 = { .day = 3, .year = 1972 };
    ret = setday(yd2);
    printf("%3d days since 1970 (ret: %d)\n", DAYS_SINCE_1970, ret);
    // 733 days since 1970 (ret: 0)

    yearday_t yd3 = { .day = 7, .year = 1955 };
    ret = setday(yd3);
    printf("%3d days since 1970 (ret: %d)\n", DAYS_SINCE_1970, ret);
     // -1 days since 1970 (ret: 1)

    return 0;
}
