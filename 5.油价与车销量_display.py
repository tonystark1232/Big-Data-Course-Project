import pandas as pd
from sqlalchemy import create_engine
from pyecharts.charts import Line, Grid, Scatter
from pyecharts import options as opts

# 从 MySQL 中读取数据
def fetch_and_process_data():
    try:
        # 数据库连接配置
        engine = create_engine(
            "mysql+pymysql://hadoop:123456@dblab:3306/ai_test_bi?charset=utf8mb4"
        )

        # 注意这里的日期格式化百分号使用单个 %，不要使用 %%
        query = """
            SELECT 
                DATE_FORMAT(STR_TO_DATE(CAST(month AS CHAR), '%Y年%m月'), '%Y-%m') AS month,
                price_92,
                sales_total,
                sales_growth_rate
            FROM ads_yj_xl_gl
            ORDER BY STR_TO_DATE(CAST(month AS CHAR), '%Y年%m月')
        """

        df = pd.read_sql(query, engine)
        df['sales_growth_rate'] = df['sales_growth_rate'].fillna(0)
        return df

    except Exception as e:
        print(f"❌ 数据库连接失败：{str(e)}")
        return pd.DataFrame()

# 构建图表
def create_combined_chart(df):
    line = (
        Line(init_opts=opts.InitOpts(width="1600px", height="600px"))
        .add_xaxis(df['month'].tolist())
        .add_yaxis(
            "92#汽油价格(元/升)", df['price_92'].round(2).tolist(),
            yaxis_index=0, color="#d14a61", symbol="triangle",
            linestyle_opts=opts.LineStyleOpts(width=3)
        )
        .add_yaxis(
            "新能源车销量(万辆)", df['sales_total'].round(1).tolist(),
            yaxis_index=1, color="#5793f3", symbol="circle",
            linestyle_opts=opts.LineStyleOpts(width=3, type_="dashed")
        )
        .extend_axis(
            yaxis=opts.AxisOpts(
                name="销量(万辆)", type_="value", position="right",
                axisline_opts=opts.AxisLineOpts(
                    linestyle_opts=opts.LineStyleOpts(color="#5793f3")
                )
            )
        )
        .set_global_opts(
            title_opts=opts.TitleOpts(title="油价与新能源车销量趋势分析", pos_top="5%"),
            datazoom_opts=[opts.DataZoomOpts(pos_bottom="15%")],
            yaxis_opts=opts.AxisOpts(name="油价(元/升)", splitline_opts=opts.SplitLineOpts(is_show=True)),
            xaxis_opts=opts.AxisOpts(name="时间", axislabel_opts=opts.LabelOpts(rotate=45))
        )
    )

    scatter = (
        Scatter()
        .add_xaxis(df['price_92'].round(2).tolist())
        .add_yaxis(
            "增长率", (df['sales_growth_rate'] * 100).round(2).tolist(),
            symbol_size=12, label_opts=opts.LabelOpts(is_show=False)
        )
        .set_global_opts(
            xaxis_opts=opts.AxisOpts(name="汽油价格(元/升)"),
            yaxis_opts=opts.AxisOpts(name="增长率(%)", axislabel_opts=opts.LabelOpts(formatter="{value}%"))
        )
    )

    grid = (
        Grid()
        .add(line, grid_opts=opts.GridOpts(pos_left="10%", pos_right="10%", height="60%"))
        .add(scatter, grid_opts=opts.GridOpts(pos_left="10%", pos_right="10%", pos_top="75%"))
    )
    return grid

# 主函数执行
if __name__ == "__main__":
    df = fetch_and_process_data()
    if not df.empty:
        chart = create_combined_chart(df)
        chart.render("energy_analysis_fixed.html")
        print("✅ 图表生成成功：energy_analysis_fixed.html")
    else:
        print("❌ 数据为空，图表生成失败。")
