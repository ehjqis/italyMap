<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>南北差距巨大的意大利</title>

    <style>
      html,
      body,
      #viewDiv {
        /* position: absolute; */
        text-align:center;
        
        width: 100%;
        height:100%;
        
        margin-left: 0px;
        /* margin-top:0px; */
      }
      #info{
          background-color: black;
          color: aquamarine;
          opacity: 0.6;
          font-size: 17pt;
          padding: 6px;
          visibility: hidden;
      }
    </style>
    <style>
			#none{}
			h1	
			{
				text-align:center;
        font: 40px;
			}
			h2	
			{
				text-align:center;
				/* text-align:center;background-image:url("https://tse1-mm.cn.bing.net/th/id/R-C.c6a8df5a7752a31a632a69534f6b19d2?rik=LFX39C0G2MCOSA&riu=http%3a%2f%2fimage.space.rakuten.co.jp%2flg01%2f43%2f0000713343%2f98%2fimgd0a7be9fzikbzj.jpeg&ehk=M8gWpTbpDM1IsjDOq4AuCt7SsqdpJIAoiyxDJ%2fYXcjc%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1"); */
				background-repeat:repeat-x;	
			}
			h4
			{
				text-align:center;
			}
			
			/* #container {width:300px; height: 180px; } */ 
			
			#grid1
			{
			background-image: linear-gradient(to right, rgba(255,165,0,1), rgba(255,0,0,0));
			}
			img
			{
			width:320px;
			height:240px;
			margin: 0 auto
			}
			.tabtop
			{
			margin: 0px auto
			}
			.font-center{text-align:center}
			.btbg1{background:#FAEBD7}
			.btbg2{background:#F8F8FF}
			.titfont
			{
			font-family:微软雅黑;
			font-size:16px;
			font-weight: bold;
			}
			#menu
			{
				font: 20px verdana, arial, sans-serif;
				list-style: none;
				padding: 0;
				margin: 0;
				float: left;

			}
			#menu li
			{
				float: left;
			}
			#menu li a
			{
				display: block;
				padding: 0px 0px;
				color: cornsilk;
				text-decoration: none;
				width:140px;
				height: 50px;
				line-height: 50px;
				text-align: center;
				
			}
			#menu li a:hover
			{
				color:white;
			}
			
			
			
		</style>

    <link rel="stylesheet" href="https://js.arcgis.com/4.25/esri/themes/light/main.css">
    <script src="https://js.arcgis.com/4.25/"></script>

    <script>
      require(["esri/config", "esri/Map", "esri/views/MapView","esri/layers/GeoJSONLayer",
      "esri/widgets/LayerList","esri/geometry/SpatialReference","esri/Basemap",
      "esri/layers/GraphicsLayer","esri/Graphic","esri/widgets/BasemapToggle","esri/widgets/Legend","esri/layers/FeatureLayer"], 
      function(esriConfig, Map, MapView,GeoJSONLayer,LayerList,SpatialReference,Basemap,GraphicsLayer,Graphic,BasemapToggle,Legend,FeatureLayer) {

        esriConfig.apiKey = "AAPK449340f85b664e6b802d2d0e65eb4849vlSII8YqKpEj5Fn0hCy2qr4QyOAZRZSB6XWDc2-X8pFlNoRYoQoetUvFs1Y_JVKL";

        const geojsonlayer = new GeoJSONLayer({
                url:"https://ehjqis.github.io/italyMap/italy_polygon.geojson",
                // url:"../italy_polygon.geojson",
                outFields:["*"],
                title: "italy_polygon",
        });

        let basemap_WGS84 = new Basemap({
            portalItem: {
                id: "8dda0e7b5e2d4fafa80132d59122268c"  // WGS84 Streets Vector webmap
            }
        });
     
        const less35 = {
          type: "simple-fill", // autocasts as new SimpleFillSymbol()
          color: "#38A800",
          style: "solid",
          outline: {
            width: 0.2,
            color: [255, 255, 255, 0.5]
          }
        };

        const less50 = {
          type: "simple-fill", // autocasts as new SimpleFillSymbol()
          color: "#8BD100",
          style: "solid",
          outline: {
            width: 0.2,
            color: [255, 255, 255, 0.5]
          }
        };

        const more50 = {
          type: "simple-fill", // autocasts as new SimpleFillSymbol()
          color: "#FFFF00",
          style: "solid",
          outline: {
            width: 0.2,
            color: [255, 255, 255, 0.5]
          }
        };

        const more75 = {
          type: "simple-fill", // autocasts as new SimpleFillSymbol()
          color: "#FF8000",
          style: "solid",
          outline: {
            width: 0.2,
            color: [255, 255, 255, 0.5]
          }
        };
        const more95 = {
          type: "simple-fill", // autocasts as new SimpleFillSymbol()
          color: "#FF0000",
          style: "solid",
          outline: {
            width: 0.2,
            color: [255, 255, 255, 0.5]
          }
        };

        

        const renderer1 = {
          type: "class-breaks", // autocasts as new ClassBreaksRenderer()
          field: "GDP_person",
          //normalizationField: "GDP_person",
          legendOptions: {
            title: "各个大区人均GDP/欧元"
          },
          defaultSymbol: {
            type: "simple-fill", // autocasts as new SimpleFillSymbol()
            color: "black",
            style: "backward-diagonal",
            outline: {
              width: 0.5,
              color: [142, 50, 233, 0.6]
            }
          },
          defaultLabel: "no data",
          classBreakInfos: [
            {
              minValue: 17923,
              maxValue: 19607,
              symbol: less35,
              label: "17923€-19607€"
            },
            {
              minValue: 19608,
              maxValue: 23230,
              symbol: less50,
              label: "19608€-23230€"
            },
            {
              minValue: 23231,
              maxValue: 29120,
              symbol: more50,
              label: "23231€-29120€"
            },
            {
              minValue: 29121,
              maxValue: 36496,
              symbol: more75,
              label: "29121€-36496€"
            },
            {
              minValue: 36497,
              maxValue: 46790,
              symbol: more95,
              label: "36497€-46790€"
            }
          ]
        };

        const seattleLayer = new GeoJSONLayer({
          url: "https://ehjqis.github.io/italyMap/italy_polygon.geojson",
          title: "人均DGP分级图",
          renderer: renderer1,
          popupTemplate: {
            
            title: " {NAME_CN}",
            content:
              "人均GDP为：{GDP_person}€  "
              
          },
          opacity: 0.9
        });
        
        const map = new Map({
            basemap: basemap_WGS84,
            layers:[geojsonlayer,seattleLayer],
            
        });
        const view = new MapView({
            map: map,
            center: [13.7,42], 
            zoom: 5, 
            container: "viewDiv" ,
            spatialReference: {wkid: 4326 },
            highlightOption:{color:"blue",haloOpacity:0.8,fillOpacity:0.2},
        });

        const legend = new Legend({
          view: view
        });
        view.ui.add(legend, "bottom-left");

        view.ui.add("info","top-right");

        const basemapToggle = new BasemapToggle({
                view: view,
                nextBasemap: "arcgis-imagery"
            });
            view.ui.add(basemapToggle,"bottom-right");
    

        map.add(geojsonlayer);
        map.add(seattleLayer);

            
        let layerList = new LayerList({
            view: view
        });
            
        view.ui.add(layerList, {
            position: "top-left"
        });
        view
          .when()
          .then(() => {
            return geojsonlayer.when();
          })
          .then((layer) => {
            const renderer = layer.renderer.clone();
            renderer.symbol.width = 4;
            renderer.symbol.color = [128, 128, 128, 0.8];
            layer.renderer = renderer;

            // Set up an event handler for pointer-down (mobile)
            // and pointer-move events (mouse)
            // and retrieve the screen x, y coordinates

            return view.whenLayerView(layer);//Gets the LayerView created on the view for the given layer. 
          })
          .then((layerView) => {
            view.on("pointer-move", eventHandler); //指针移动
            view.on("pointer-down", eventHandler);
            function eventHandler(event) {
              // only include graphics from hurricanesLayer in the hitTest
              const opts = {
                include: geojsonlayer,
              };
              // the hitTest() checks to see if any graphics from the hurricanesLayer
              // intersect the x, y coordinates of the pointer
              view.hitTest(event, opts).then(getGraphics);
            }

            let highlight,provinceName,provincePop,GDP;

            function getGraphics(response) {
              // the topmost graphic from the hurricanesLayer
              // and display select attribute values from the
              // graphic to the user
              if (response.results.length) {
                const graphic = response.results[0].graphic;
                  
                const attributes = graphic.attributes;

                const name = attributes.NAME_CN;
                const area = attributes.POPU;
                const id = attributes.NUTS_ID;
                const gdp = attributes.GDP_euro;

                if (
                    highlight &&
                    (provinceName !== name || provincePop !== area||GDP !==gdp )
                ) {
                    highlight.remove();
                    highlight = null;
                    return;
                }

                if (highlight) {
                    return;
                }
                document.getElementById("info").style.visibility = "visible";
                document.getElementById("Name").innerHTML = "区名："+name;
                document.getElementById("Area").innerHTML = "人口：" + area;
                document.getElementById("GDP").innerHTML = "GDP：" + gdp+"million €";

                const query = layerView.createQuery();
                    //允许对图层中的字段操作任何合法 SQL where 子句。在 JavaScript 中编写 where 子句时，请确保具有正确的单引号和双引号序列
                    query.where = "PROV = ' " + name + "'  AND pop2010 = " + area ;
                    layerView.queryObjectIds(query).then((ids) => {
                        if(highlight){
                            highlight.remove();
                        }
                        highlight = layerView.highlight(ids);
                        provinceName = name;
                        provincePop = area;
                        GDP = gdp;
                    });
                    view.graphics.removeAll();//清除上一次操作

                    const selectGraphic = new Graphic({
                        geometry : graphic.geometry,
                        symbol:{
                            type: "simple-fill", 
                            color: [51, 204, 255, 0.7],
                            
                            outline: {  
                                color: [128, 128, 128, 0.5],
                                width: "0.5px"
                            }
                        }
                    });

                    view.graphics.add(selectGraphic);//graphics


                }else{
                    // remove the highlight if no features are
                    // returned from the hitTest
                    if (highlight) {
                        highlight.remove();
                        highlight = null;
                    }
                    document.getElementById("info").style.visibility = "hidden";
                    view.graphics.removeAll();//清除上一次操作
                }
            }
        });


      });
    </script>

  </head>
  <body>
    <div id="上方状态栏" style="width: 100%; height: 50px; color: #d5d5d5; background-color: #545652;">
			<div id="导航栏加下拉菜单" style="width: 100%; height: 50px;">
				<div  style="width: 30%; height: 50px; float:left ">
					<ul id="menu">
						<li >
							<a href="https://baike.baidu.com/item/%E6%84%8F%E5%A4%A7%E5%88%A9/148336" >意大利简介</a>
						</li>
						<li >
							<a href="https://www.istat.it/en/" >意大利统计局</a>
						</li>
						<li >
							<a href="https://ehjqis.github.io/italyMap/italy_polygon.geojson" >json下载</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div id="标题" width=100%; height:100px; position: absolute; margin: auto;>
			<div style="width: 85%; height:100px; float:left ">
				<h1 text-align:center;>南北差距巨大的意大利</h1>
			</div>
			<div style="width: 15%; height:100px;     display: flex; align-items: center; float:right ;margin: auto;">
					<audio controls = "controls">
						<source src= "https://m10.music.126.net/20221231142811/a0192a9d1649c16ac32f72ab96dbc4fb/ymusic/2b71/f341/7e58/02d5ded21349c8805c80771a71e35fd5.mp3" type ="audio/mp3"></source>
					</audio>
			</div>
		</div>
    
    <h5><b id="grid1" style="font-size:40px">概况</b></h5>
		<p style="text-indent:2em;">意大利是发达国家，2020年GDP总量为1.89万亿美元，世界排名第八；人均GDP3.14万美元，世界排名第28。意大利划分为20个行政大区，大区之间发展不平衡，北方比南方富裕.</p>
		<table text-align:center;>
      <tr text-align:center;>
        <td><img src="https://desk-fd.zol-img.com.cn/t_s960x600c5/g5/M00/0B/02/ChMkJ1diE8yIOq34AAeY3EgSuVEAASp-QFamhwAB5j0610.jpg" width="90" height="90" alt=""></td>
      
      <td>意大利的经济包括一个由私营公司主导的发达的北方工业，以及一个欠发达、高度补贴的南方。阿尔卑斯山脚下的北方区域，经济可以与法国、德国相媲美，南方就显得不那么乐观。北方聚集了全国大多数重工业（钢铁，汽车，石油，化工）；南方则主要依靠农业，渔业，旅游业，例如在南方的西西里岛和那不勒斯是很好的旅游度假选择。</td>  

      <td><img src="https://ts1.cn.mm.bing.net/th/id/R-C.5106bb8c69c2131b961f9041a35774ac?rik=URfWeoTwyhvBmA&riu=http%3a%2f%2fpic.bizhi360.com%2fbpic%2f27%2f8227.jpg&ehk=FYyxAdSAPO15qa0zCNHxbTTVTy%2brVBdkXsfEku7TiFw%3d&risl=&pid=ImgRaw&r=0" width="90" height="90" alt=""></td>
    </tr>
      </table>
    <pre>

      </pre>
      <table width="70%"; border="1";cellpadding="10";cellspacing="1";align="center"; class="tabtop"; >
        <caption>意大利南北差距</caption>
        <tr>
          <td width="100px" class="btbg1 font-center titfont"></td>
          <td width="100px" class="btbg1 font-center titfont">主要产业</td>
          <td width="100px" class="btbg1 font-center titfont">所在大区人均GDP          </td>
        </tr>
        
        <tr>
          <td width="100px" class="btbg2 font-center">米兰</td>
          <td width="100px" class="btbg2 font-center">金属机械机器制造、航空、冶金、化工、制药、化纤、纺织服装、橡胶</td>
          <td width="200px" class="btbg2 font-center">38600万美元</td>
        </tr>
        
        <tr>
          <td width="100px" class="btbg2 font-center">都灵</td>
          <td width="100px" class="btbg2 font-center">意大利的汽车城（菲亚特），发动机、机床、电子、电器、化学、轴承、飞机、精密仪器</td>
          <td width="200px" class="btbg2 font-center">31500万美元</td>
        </tr>
        
        <tr>
          <td width="100px" class="btbg2 font-center">南方</td>
          <td width="100px" class="btbg2 font-center"></td>
          <td width="200px" class="btbg2 font-center"></td>
        </tr>

        <tr>
          <td width="100px" class="btbg2 font-center">巴勒莫</td>
          <td width="100px" class="btbg2 font-center">机械、造船、化学、纺织、食品、印刷，玻璃，农产品集散地，渔港，输出柑橘、谷物、鲜鱼</td>
          <td width="200px" class="btbg2 font-center">17800万美元</td>
        </tr>
        
        <tr>
          <td width="100px" class="btbg2 font-center">那不勒斯</td>
          <td width="100px" class="btbg2 font-center">货运港口，旅游业，服务业</td>
          <td width="200px" class="btbg2 font-center">18600万美元</td>
        </tr>
      </table>
      <div>
        <h4>在地图上可以直观地反映出意大利的南北差距</h3>
      </div>
		<hr />

    <div id="viewDiv"></div>
    <div id="info">
        <span id = "Name"></span> <br />
        <span id = "Area"></span> <br />
        <span id = "GDP"></span> 
      </div>
      <hr />
    <div>	
    <p style="text-align:center;" >如果有问题，欢迎向我们反馈。这是我们的电子邮箱链接：<a href="mailto:1328222357@qq.com?subject=Some_advice&body=sone_text" rel="nofollow" target="_top">发送邮件</a></p>
    </div>
  </body>
</html>