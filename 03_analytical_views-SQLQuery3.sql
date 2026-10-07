USE TradingIntelligenceDB;
GO

CREATE VIEW v_SymbolPerformance AS
SELECT
    Symbol,
    COUNT(TradeNumber)/2 AS Total_Trades_Executed,
    SUM(Net_PnL_USD) AS Total_Net_Profit_USD,
    AVG(Return_Pct) AS Average_Return_Per_Trade_Pct
FROM ExecutedTrades
GROUP BY Symbol;
GO

CREATE VIEW v_WinlossMetrics AS
SELECT
    Symbol,
    SUM(CASE WHEN Net_PnL_USD > 0 AND Type LIKE 'Exit%' THEN 1 ELSE 0 END) AS Winning_Trades,
    SUM(CASE WHEN Net_PnL_USD <= 0 AND Type LIKE 'Exit%' THEN 1 ELSE 0 END) AS Losing_Trades,
    CAST(SUM(CASE WHEN Net_PnL_USD > 0 AND Type LIKE 'EXIT%' THEN 1 ELSE 0 END) * 100.0 / (COUNT(TradeNumber) / 2) AS DECIMAL(5,2)) AS Win_Rate_Percentage
FROM ExecutedTrades
GROUP BY Symbol;
GO
