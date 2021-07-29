#  Cargamos las Librerias ----------------------------------------------------------
require(pacman)
pacman::p_load(raster, ggplot2, ggspatial, colorspace, ggpubr, RColorBrewer, sf)
#----------------------------------------------------------
Cobe            <- raster("Data_raster/Puma/Puma_concolor.asc")
dem.p          <-  rasterToPoints(Cobe)
df             <-  data.frame(dem.p)
#----------------------------------------------------------
gg<- ggplot()+
  geom_raster(data = df, aes(x,y, fill = Puma_concolor))+
  scale_fill_gradientn(colours=c("green","green4","yellow","orange","red"),
                       limits = c(0, 1), breaks = seq(0, 1, 0.2),
                       labels = c("[0 - 0.19] ","[0.2 - 0.39]", "[0.4 - 0.59]", "[0.6 - 0.79]", "[0.8 - 0.96]", "[0.97]"))+
  annotation_north_arrow(location="tr",which_north="true",style=north_arrow_fancy_orienteering ())+
  ggspatial::annotation_scale(location = "bl",bar_cols = c("grey60", "white"), text_family = "ArcherPro Book")+
  guides(fill = guide_legend(title.position = "top",direction = "vertical",
                             title.theme = element_text(angle = 0, size = 10, colour = "black", face = "bold"),
                             barheight = .5, barwidth = .95,
                             title.hjust = 0.5, raster = FALSE,
                             title = 'Idoneidad de \nhabitat'))+
  theme_bw()+
  theme(panel.grid.major = element_line(color = gray(.5),
                                        linetype = "dashed", size = 0.5),
        panel.background = element_rect(fill = "white"),
        legend.background = element_blank(),
        legend.position = c(.65, .15),
        legend.key = element_blank(),
        legend.key.size = unit(0.3, "cm"), #alto de cuadrados de referencia
        legend.key.width = unit(0.3,"cm"), #ancho de cuadrados de referencia 
        legend.text =element_text(size=9), #tamaño de texto de leyenda
        legend.justification = c("left", "bottom"),
        plot.title=element_text(color="#666666", size=12, vjust=1.25,  family="Raleway",  hjust = 0.5),
        legend.box.just = "left")+
  scale_x_continuous(name=expression(paste("Longitude (",degree,")"))) +
  scale_y_continuous(name=expression(paste("Latitude (",degree,")")))+
  annotate(geom = "text", x = 9e+05, y = 9410000, 
           label = "Modelo de la idoneidad del Habitat para esta especie \nen base al algoritmo de maxima entropia (MAXENT). ", 
           fontface = "italic", color = "black", size = 3)+
  labs(title = "Mapa de Distribucion potencial de Puma concolor",
       caption = "Castellanos, A y Vallejo, A.F. 2020. Puma concolor En: Brito, J., \nCamacho, M. A., Romero, V. Vallejo, A. F. (eds). \nMamíferos del Ecuador. Version 2018.0. Museo de Zoología, \nPontificia Universidad Católica del Ecuador. \nhttps://bioweb.bio/faunaweb/mammaliaweb/FichaEspecie/Puma%20concolor")
#----------------------------------------------------------
ggsave(plot = gg ,"Mapas exportados/Mapa de distribuvion de especies probabilidad.png", units = "cm", 
       width = 21,height = 29, dpi = 900)

