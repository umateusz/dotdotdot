# tested with sqlalchemy 1.3.2

import numpy as np
import psycopg2.extensions


def as_is_adapter(x):
    return psycopg2.extensions.AsIs(x)


psycopg2.extensions.register_adapter(np.float64, as_is_adapter)
psycopg2.extensions.register_adapter(np.int64, as_is_adapter)
