close all
clear
cmap = [0.00196078442968428 0.00196078442968428 0.00196078442968428;
    0.041960783302784 0.0405107848346233 0.0403607860207558;
    0.0819607824087143 0.0767607837915421 0.0755607858300209;
    0.121960781514645 0.111610785126686 0.107560783624649;
    0.161960780620575 0.145960777997971 0.13636077940464;
    0.201960787177086 0.180710777640343 0.161960780620575;
    0.241960778832436 0.216760784387589 0.184360787272453;
    0.281960785388947 0.255010783672333 0.203560784459114;
    0.321960777044296 0.296360790729523 0.219560787081718;
    0.361960798501968 0.341710776090622 0.232360780239105;
    0.401960790157318 0.391960769891739 0.241960778832436;
    0.435910791158676 0.441960781812668 0.24836078286171;
    0.453160792589188 0.481960773468018 0.251560777425766;
    0.462810784578323 0.52196079492569 0.251560777425766;
    0.46396079659462 0.561960756778717 0.24836078286171;
    0.455710798501968 0.601960778236389 0.241960778832436;
    0.437160789966583 0.641960799694061 0.232360780239105;
    0.407410770654678 0.681960761547089 0.219560787081718;
    0.36556077003479 0.721960783004761 0.203560784459114;
    0.310710787773132 0.761960804462433 0.184360787272453;
    0.241960778832436 0.80196076631546 0.161960780620575;
    0.158410787582397 0.841960787773132 0.13636077940464;
    0.107560783624649 0.881960809230804 0.155960783362389;
    0.0755607858300209 0.921960771083832 0.207810789346695;
    0.0403607860207558 0.961960792541504 0.270760774612427;
    0.00196078442968428 1 0.345710784196854;
    0.00196078442968428 1 0.439460784196854;
    0.00196078442968428 1 0.533210813999176;
    0.00196078442968428 1 0.626960813999176;
    0.00196078442968428 1 0.720710813999176;
    0.00196078442968428 1 0.814460813999176;
    0.00196078442968428 1 0.908210813999176;
    0.00196078442968428 1 1;
    0.00196078442968428 0.908210813999176 1;
    0.00196078442968428 0.814460813999176 1;
    0.00196078442968428 0.720710813999176 1;
    0.00196078442968428 0.626960813999176 1;
    0.00196078442968428 0.533210813999176 1;
    0.00196078442968428 0.439460784196854 1;
    0.00196078442968428 0.345710784196854 1;
    0.00196078442968428 0.251960784196854 1;
    0.00196078442968428 0.158210784196854 1;
    0.00196078442968428 0.0644607841968536 1;
    0.0332107841968536 0.00196078442968428 1;
    0.126960784196854 0.00196078442968428 1;
    0.220710784196854 0.00196078442968428 1;
    0.314460784196854 0.00196078442968428 1;
    0.408210784196854 0.00196078442968428 1;
    0.501960813999176 0.00196078442968428 1;
    0.595710813999176 0.00196078442968428 1;
    0.689460813999176 0.00196078442968428 1;
    0.783210813999176 0.00196078442968428 1;
    0.876960813999176 0.00196078442968428 1;
    0.970710813999176 0.00196078442968428 1;
    1 0.00196078442968428 0.939460813999176;
    1 0.00196078442968428 0.845710813999176;
    1 0.00196078442968428 0.751960813999176;
    1 0.00196078442968428 0.658210813999176;
    1 0.00196078442968428 0.564460813999176;
    1 0.00196078442968428 0.470710784196854;
    1 0.00196078442968428 0.376960784196854;
    1 0.00196078442968428 0.283210784196854;
    1 0.00196078442968428 0.189460784196854;
    1 0.00196078442968428 0.0957107841968536];

fname = '#Filename#.tif';
im = imread(fname);
figure('WindowState','maximized')
imagesc(im)
colormap(hot)
caxis([3000, 30000])
axis equal
axis off
%colorbar

export_fig(sprintf("%s.png",fname(1:end-4)), "-transparent", "-native")