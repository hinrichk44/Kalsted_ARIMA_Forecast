#ARIMA Forecasting
#We will be working with the lynx dataset
#Annual numbers of lynx trappings for 1821--1934 in Canada.

#Setting up simple ARIMA model first
#Must import forecast library for auto.arima()

library(forecast)

lynxarima <- auto.arima(lynx,
                        stepwise = F,
                        approximation = F)

#Setting up forecast of 10 years

lynxforecast <- forecast(lynxarima, h = 10)

#Here we are plotting our forecast
#Looks fairly in tune with the historical data
plot(lynxforecast)

#Here we are viewing the actual forecasted values
lynxforecast$mean

#Here we are plotting a range of the last real observations and 
#the forecasted values

plot(lynxforecast, xlim = c(1930, 1944))


#One thing we can do to verify our forecast is to compare it to an ETS model
#ETS stands for Error, Trend, Seasonality

lynxets <- ets(lynx)

#Setting up ETS forecast
etsforecast <- forecast(lynxets, h = 10)

#Now we will plot both forecasts together
#Must upload ggplot
library(ggplot2)

autoplot(lynx) +
  forecast::autolayer(etsforecast$mean, series = 'ETS model') +
  forecast::autolayer(lynxforecast$mean, series = 'ARIMA model') +
  xlab('Year') + ylab('Lynx Trappings') +
  guides(colour = guide_legend(title = 'Forecast Method')) +
  theme(legend.position = c(0.8, 0.8))

#The ARIMA forecast is clearly better