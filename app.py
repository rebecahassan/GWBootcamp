from matplotlib import style
style.use('fivethirtyeight')
import matplotlib.pyplot as plt

import numpy as np
import pandas as pd
from scipy.stats import sem
import datetime as dt

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func
from sqlalchemy.orm import scoped_session
from sqlalchemy.orm import sessionmaker

from flask import Flask, jsonify


#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
#session = Session(engine)
session = scoped_session(sessionmaker(bind=engine))
#################################################
# Flask Setup
#################################################
app = Flask(__name__)


#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"
        f"/api/v1.0/temp/<start> (Enter Start Date Only)<br/>"
        f"/api/v1.0/temp/<start>/<end> (Enter Range)"

    )

@app.route("/api/v1.0/precipitation")
def precipitation():
    """Return the precipitation data for the last year"""
    # Calculate the date 1 year ago from last date in database
    prev_year = dt.date(2017, 8, 23) - dt.timedelta(days=365)

    # Query for the date and precipitation for the last year
    precipitation = session.query(Measurement.date, Measurement.prcp).\
        filter(Measurement.date >= prev_year).all()

    # Dict with date as the key and prcp as the value
    precip = {date: prcp for date, prcp in precipitation}
    return jsonify(precip)

@app.route("/api/v1.0/stations")
def stations():
    stations = session.query(Measurement.station).\
        group_by(Measurement.station).all()
    # Convert list of tuples into normal list
    lst_stations = list(np.ravel(stations))
    return jsonify(lst_stations)

@app.route("/api/v1.0/tobs")
def tobs():
    # Calculate the date 1 year ago from last date in database
    prev_year = dt.date(2017, 8, 23) - dt.timedelta(days=365)

    tobs = session.query(Measurement.date, Measurement.tobs).\
        filter(Measurement.date >=prev_year).all()
    # Convert list of tuples into normal list
    lst_tobs = list(np.ravel(tobs))
    return jsonify(lst_tobs)

@app.route("/api/v1.0/temp/<start>")
@app.route("/api/v1.0/temp/<start>/<end>")
def stats(start=None, end=None):
#    """Return TMIN, TAVG, TMAX."""

    if end ==None:
        end = stats=session.query(func.max(Measurement.date)).first()[0]

    stats=session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= start).filter(Measurement.date <= end).all()
    
    lst_stats = list(np.ravel(stats))
    return jsonify(lst_stats)

if __name__ == '__main__':
    app.run(debug=True)
