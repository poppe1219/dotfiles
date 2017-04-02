#!/usr/bin/python3

from __future__ import division
from math import *
from random import *

_LINES = [
    ['π: %.30f' % pi, 'e: %.30f' % e],
    ['--- Number-theoretic and representation functions ---'],
    ['ceil(x)', 'Return the ceiling of x, the smallest integer greater than or equal to x.'],
    ['copysign(x, y)', 'Return a float with the magnitude of x but the sign of y.'],
    ['fabs(x)', 'Return the absolute value of x.'],
    ['factorial(x)', 'Return x factorial.'],
    ['floor(x)', 'Return the floor of x, the largest integer less than or equal to x.'],
    ['fmod(x, y)', 'Return fmod(x, y), as defined by the platform C library.'],
    ['frexp(x)', 'Return the mantissa and exponent of x as the pair (m, e).'],
    ['fsum(iterable)', 'Return an accurate floating point sum of values in the iterable.'],
    ['gcd(a, b)', 'Return the greatest common divisor of the integers a and b.'],
    ['--- Power and logarithmic functions ---'],
    ['exp(x)', 'Return e**x.'],
    ['expm1(x)', 'Return e**x - 1. For small floats x, provides a way to compute this quantity to full precision.'],
    ['log(x[, base])', 'With one argument, return the natural logarithm of x (to base e).'],
    ['log1p(x)', 'Return the natural logarithm of 1+x (base e), is accurate for x near zero.'],
    ['log2(x)', 'Return the base-2 logarithm of x. This is usually more accurate than log(x, 2).'],
    ['log10(x)', 'Return the base-10 logarithm of x. This is usually more accurate than log(x, 10).'],
    ['pow(x, y)', 'Return x raised to the power y.'],
    ['sqrt(x)', 'Return the square root of x.'],
    ['--- Trigonometric functions ---'],
    ['acos(x)', 'Return the arc cosine of x, in radians.'],
    ['asin(x)', 'Return the arc sine of x, in radians.'],
    ['atan(x)', 'Return the arc tangent of x, in radians.'],
    ['atan2(y, x)', 'Return atan(y / x), in radians. The result is between -pi and pi.'],
    ['cos(x)', 'Return the cosine of x radians.'],
    ['hypot(x, y)', 'Return the Euclidean norm, sqrt(x*x + y*y).'],
    ['sin(x)', 'Return the sine of x radians.'],
    ['tan(x)', 'Return the tangent of x radians.'],
    ['--- Angular conversion ---'],
    ['degrees(x)', 'Convert angle x from radians to degrees.'],
    ['radians(x)', 'Convert angle x from degrees to radians.'],
    ['--- Hyperbolic functions ---'],
    ['acosh(x)', 'Return the inverse hyperbolic cosine of x.'],
    ['asinh(x)', 'Return the inverse hyperbolic sine of x.'],
    ['atanh(x)', 'Return the inverse hyperbolic tangent of x.'],
    ['cosh(x)', 'Return the hyperbolic cosine of x'],
    ['sinh(x)', 'Return the hyperbolic sine of x.'],
    ['tanh(x)', 'Return the hyperbolic tangent of x.'],
    ['--- To show this help, type: show_help() ---'],
]


def show_help():
    _print_lines(_LINES)

def _print_lines(lines):
    for line in lines:
        _print_info_line(line)


def _print_info_line(line):
    if len(line) is 0:
        line = '    '
    if len(line) is 1:
        line = '    {0}'.format(line[0])
    if len(line) is 2:
        line = '    {0: <16}{1}'.format(line[0], line[1])
    print(line)


_print_lines(_LINES)

