import matplotlib.pyplot as plt
import numpy as np

def plot_results(means, significance, title):
    """
    Plot a bar chart with standard deviation error bars and significance stars.

    Parameters:
    - means: list of mean values for each category.
    - significance: list of significance levels for each category ('*' for p < 0.05, '**' for p < 0.001, '' for no significance).
    - title: Title of the plot.
    """
    categories = ['incong', 'cong', 'Incong-cong']

    # Bar plot
    fig, ax = plt.subplots()
    bars = ax.bar(categories, means, capsize=5, color=['green', 'blue', 'black'], alpha=0.7, label=categories)

    # Add significance stars exactly on top of the bars
    for bar, sig in zip(bars, significance):
        yval = bar.get_height()
        if sig:
            ax.text(bar.get_x() + bar.get_width() / 2, yval,  # No offset, text placed exactly at bar height
                    sig, ha='center', va='bottom', color='black', fontsize=14)

    # Labels and title
    ax.set_ylabel('Mean Value')
    ax.set_title(f'{title}')
    ax.set_ylim(0, max(means) * 1.2)

    # Display the plot
    plt.show()

