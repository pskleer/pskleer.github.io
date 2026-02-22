# -*- coding: utf-8 -*-
"""
Created on Fri Feb 20 10:04:06 2026

@author: pskleer
"""

import pandas as pd
import matplotlib.pyplot as plt


def report(model, decimals=2, figsize=(8, 5)):
    """
    Generates sensitivity report tables and plots them as matplotlib figures.

    Parameters
    ----------
    model : gurobipy.Model
        Optimized linear model
    decimals : int
        Number of decimals to display
    figsize : tuple
        Size of matplotlib figure

    Returns
    -------
    (variables_df, constraints_df)
    """

    # ======================
    # VARIABLE TABLE
    # ======================
    var_rows = []
    
    for v in model.getVars():
        low = round(v.SAObjLow, decimals)
        high = round(v.SAObjUp, decimals)
    
        interval = "[" + str(low) + ", " + str(high) + "]"
    
        var_rows.append({
            "Variables": v.VarName,
            "Opt. Value": round(v.X, decimals),
            "Obj. Coeff.": round(v.Obj, decimals),
            "OFC Range": interval
        })
    
    variables_df = pd.DataFrame(var_rows)



    # ======================
    # CONSTRAINT TABLE
    # ======================
    con_rows = []
    
    for c in model.getConstrs():
        low = round(c.SARHSLow, decimals)
        high = round(c.SARHSUp, decimals)
    
        interval = "[" + str(low) + ", " + str(high) + "]"
    
        con_rows.append({
            "Constraints": c.ConstrName,
            "Shadow Price": round(c.Pi, decimals),
            "RHS": round(c.RHS, decimals),
            "Allowable Range": interval
        })
    
    constraints_df = pd.DataFrame(con_rows)

    
    # ======================
    # PLOT TABLES
    # ======================
    fig, axes = plt.subplots(2, 1, figsize=figsize)
    
    for ax in axes:
        ax.axis("off")
    
    axes[0].set_title("Sensitivity Report")
    
    table1 = axes[0].table(
        cellText=variables_df.values,
        colLabels=variables_df.columns,
        loc="center"
    )
    
    
    
    table2 = axes[1].table(
        cellText=constraints_df.values,
        colLabels=constraints_df.columns,
        loc="center"
    )
    
    # Print headers in bold face
    for col in range(len(variables_df.columns)):
        table1[(0, col)].set_text_props(weight='bold')

    for col in range(len(constraints_df.columns)):
        table2[(0, col)].set_text_props(weight='bold')


    # Formats the table nicely
    table1.auto_set_font_size(False)
    table1.set_fontsize(10)
    table1.scale(0.7, 1.5)
    
    table2.auto_set_font_size(False)
    table2.set_fontsize(10)
    table2.scale(0.7, 1.5)
    
    plt.tight_layout() 
    plt.show()
    return 

"""
# Elementary code for outputting report in Console


# Set print options of pandas Dataframe
pd.set_option("display.max_rows", None)
pd.set_option("display.max_columns", None)
pd.set_option("display.float_format", "{:.2f}".format)

# ======================
# VARIABLES TABLE
# ======================
var_rows = []

for v in co2_model.getVars():
    var_rows.append({
        "Variable": v.VarName,
        "Value": v.X,
        "Obj. Coeff.": v.Obj,
        "OFC-high": v.SAObjUp,
        "OFC-low": v.SAObjLow
    })

OFC_report = pd.DataFrame(var_rows)


# ======================
# CONSTRAINTS TABLE
# ======================
con_rows = []

for c in co2_model.getConstrs():
    con_rows.append({
        "Constraint": c.ConstrName,
        "Slack": c.Slack,
        "Shadow Price": c.Pi,
        "RHS": c.RHS,
        "RHS-up": c.SARHSUp,
        "RHS-low": c.SARHSLow
    })

RHS_report = pd.DataFrame(con_rows)


# ======================
# DISPLAY RESULTS
# ======================
print("\nVARIABLE REPORT")
print(OFC_report)

print("\nCONSTRAINT REPORT")
print(RHS_report)

"""