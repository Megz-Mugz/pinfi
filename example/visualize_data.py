import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# -------------------------------------------------
# Load CSV
# -------------------------------------------------
CSV_FILE = "pinfi_results.csv"
df = pd.read_csv(CSV_FILE)

# Ensure numeric columns
df["masked"] = pd.to_numeric(df["masked"])
df["avg_time"] = pd.to_numeric(df["avg_time"])

# -------------------------------------------------
# Helper to plot quadrant graph
# -------------------------------------------------
def plot_quadrant(df_subset, title, o0_name):
    o0 = df_subset[df_subset["executable"] == o0_name].iloc[0]

    # Relative metrics
    df_subset = df_subset.copy()
    df_subset["rel_masked"] = df_subset["masked"] - o0["masked"]
    df_subset["rel_time"] = df_subset["avg_time"] - o0["avg_time"]

    fig, ax = plt.subplots(figsize=(8, 8))

    # Axes through origin (O0)
    ax.axhline(0, color="black", linewidth=1)
    ax.axvline(0, color="black", linewidth=1)

    # Scatter points
    ax.scatter(
        df_subset["rel_time"],
        df_subset["rel_masked"],
        s=80,
        alpha=0.8
    )

    # Annotate points
    for _, row in df_subset.iterrows():
        label = row["executable"].replace("_exec", "").replace("_static", "")
        ax.annotate(
            label,
            (row["rel_time"], row["rel_masked"]),
            textcoords="offset points",
            xytext=(5, 5),
            fontsize=9
        )

    # Highlight O0
    ax.scatter(0, 0, color="red", s=120, label="O0 baseline")
    ax.legend()

    # Labels & title
    ax.set_xlabel("Δ Avg Runtime (relative to O0)")
    ax.set_ylabel("Δ Masked Faults (relative to O0)")
    ax.set_title(title)

    ax.grid(True, linestyle="--", alpha=0.4)
    plt.tight_layout()
    plt.show()


# -------------------------------------------------
# Split static vs dynamic
# -------------------------------------------------
dynamic_df = df[~df["executable"].str.endswith("_static")]
static_df  = df[df["executable"].str.endswith("_static")]

# -------------------------------------------------
# Plot
# -------------------------------------------------
plot_quadrant(
    dynamic_df,
    title="Dynamic Executables: Performance vs Reliability (relative to O0)",
    o0_name="basicmath_O0_exec"
)

plot_quadrant(
    static_df,
    title="Static Executables: Performance vs Reliability (relative to O0)",
    o0_name="basicmath_O0_exec_static"
)