import pandas as pd
import numpy as np

file_path = r"c:\Users\Administrator\OneDrive\Desktop\TradingHistoryDataAnalyticsPortfolio\Paper-trading-trade-history-2026-10-06T13_18_41.551Z_2bd14.xlsx"
df= pd.read_excel(file_path)

df.columns = df.columns.str.strip()

print("Columns isolated successfully:", df.columns.tolist())

df['Net PnL USD'] = pd.to_numeric(df['Net PnL USD'], errors='coerce')
df['Return %'] = pd.to_numeric(df['Return %'], errors='coerce')

profit_summary = df.groupby('Symbol')['Net PnL USD'].sum().reset_index()
print_summary = profit_summary.sort_values(by='Net PnL USD', ascending=False)

print("\n Revenue driver RANKING (Highest to lowest Pnl):")
print(print_summary.to_string(index=False))

output = r"c:\Users\Administrator\OneDrive\Desktop\TradingHistoryDataAnalyticsPortfolio\cleaned_trading_data.csv"
df.to_csv(output, index=False)
print(f"\n System Update: Cleaned data exported successfully to {output}")

