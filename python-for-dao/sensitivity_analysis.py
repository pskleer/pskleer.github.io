import pandas as pd
import matplotlib.pyplot as plt

def report(model, decimals=2):
    """
    Generates a sensitivity report for a Gurobi model with dynamically scaled figure size.

    Parameters
    ----------
    model : gurobipy.Model
        Optimized Gurobi model
    decimals : int
        Number of decimals to display

    Returns
    -------
    variables_df, constraints_df : pandas.DataFrame
        DataFrames containing variable and constraint sensitivity data
    """

    # ======================
    # VARIABLES TABLE
    # ======================
    var_rows = []
    for v in model.getVars():
        low = round(v.SAObjLow, decimals)
        high = round(v.SAObjUp, decimals)
        interval = f"[{low}, {high}]"

        var_rows.append({
            "Variables": v.VarName,
            "Opt. Value": round(v.X, decimals),
            "Obj. Coeff.": round(v.Obj, decimals),
            "OFC Range": interval
        })
    
    variables_df = pd.DataFrame(var_rows)


    # ======================
    # CONSTRAINTS TABLE
    # ======================
    con_rows = []
    for c in model.getConstrs():
        low = round(c.SARHSLow, decimals)
        high = round(c.SARHSUp, decimals)
        interval = f"[{low}, {high}]"

        con_rows.append({
            "Constraints": c.ConstrName,
            "Shadow Price": round(c.Pi, decimals),
            "RHS": round(c.RHS, decimals),
            "Allowable Range": interval
        })
    
    constraints_df = pd.DataFrame(con_rows)


    # ======================
    # PLOT TABLES (DYNAMIC SIZE)
    # ======================
    n_var = len(variables_df)
    n_con = len(constraints_df)

    # Scaling factors (adjust as needed)
    row_height = 0.4
    header_space = 1.2

    height_var = header_space + n_var * row_height
    height_con = header_space + n_con * row_height
    total_height = height_var + height_con

    fig, axes = plt.subplots(
        2, 1,
        figsize=(12, total_height),
        gridspec_kw={'height_ratios': [height_var, height_con]}
    )

    for ax in axes:
        ax.axis("off")

    axes[0].set_title("Sensitivity Report", fontsize=14, weight="bold")

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

    # Bold headers
    for col in range(len(variables_df.columns)):
        table1[(0, col)].set_text_props(weight='bold')

    for col in range(len(constraints_df.columns)):
        table2[(0, col)].set_text_props(weight='bold')

    # Set font size manually
    for table in [table1, table2]:
        table.auto_set_font_size(False)
        table.set_fontsize(9)

    plt.tight_layout()
    plt.show()

    return 