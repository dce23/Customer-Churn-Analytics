import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Set aesthetics
sns.set_theme(style="whitegrid")
plt.rcParams.update({'font.sans-serif': 'Arial', 'font.family': 'sans-serif'})

# Load Data
df = pd.read_csv('saas_customer_churn.csv')
df['plan_tier'] = df['plan_tier'].str.strip().str.upper()

# 1. Figure Setup
fig, axes = plt.subplots(1, 3, figsize=(18, 5))

# Plot 1: Churn Rate by Plan Tier
churn_by_tier = df.groupby('plan_tier')['churned'].mean().reset_index()
sns.barplot(
    data=churn_by_tier, 
    x='plan_tier', 
    y='churned', 
    ax=axes[0], 
    palette='Blues_r'
)
axes[0].set_title('Churn Rate by Plan Tier', fontsize=14, fontweight='bold', pad=10)
axes[0].set_xlabel('Plan Tier')
axes[0].set_ylabel('Churn Rate')
axes[0].set_ylim(0, 0.5)
for p in axes[0].patches:
    axes[0].annotate(f'{p.get_height():.1%}', 
                     (p.get_x() + p.get_width() / 2., p.get_height()), 
                     ha='center', va='center', xytext=(0, 8), textcoords='offset points')

# Plot 2: Support Tickets vs. Churn Status
sns.boxplot(
    data=df, 
    x='churned', 
    y='support_tickets_30d', 
    ax=axes[1], 
    palette=['#2b5c8f', '#d9534f']
)
axes[1].set_title('Support Tickets (30d) by Churn Status', fontsize=14, fontweight='bold', pad=10)
axes[1].set_xticklabels(['Retained', 'Churned'])
axes[1].set_xlabel('Customer Status')
axes[1].set_ylabel('30-Day Support Tickets')

# Plot 3: Engagement (Login Hours) vs. Churn Density
sns.kdeplot(
    data=df, 
    x='monthly_login_hours', 
    hue='churned', 
    common_norm=False, 
    palette=['#2b5c8f', '#d9534f'], 
    fill=True,
    ax=axes[2]
)
axes[2].set_title('Monthly Login Hours Density', fontsize=14, fontweight='bold', pad=10)
axes[2].set_xlabel('Monthly Login Hours')
axes[2].set_ylabel('Density')
axes[2].legend(title='Status', labels=['Churned', 'Retained'])

plt.tight_layout()
plt.savefig('py_churn_analysis.png', dpi=300)
plt.show()