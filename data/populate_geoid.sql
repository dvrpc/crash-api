/* create a geoid table for all our counties and muncipalities */

BEGIN;

INSERT INTO geoid (state, county, municipality, geoid) VALUES
    ('pa', NULL, NULL, 42),
    ('nj', NULL, NULL, 34),
    ('pa', 'Bucks', NULL, 42017),
    ('pa', 'Chester', NULL, 42029),
    ('pa', 'Delaware', NULL, 42045),
    ('pa', 'Montgomery', NULL, 42091),
    ('pa', 'Philadelphia', NULL, 42101),
    ('nj', 'Gloucester', NULL, 34015),
    ('nj', 'Camden', NULL, 34007),
    ('nj', 'Burlington', NULL, 34005),
    ('nj', 'Mercer', NULL, 34021),
    ('pa', 'Montgomery', 'Abington Township', 4209100156),
    ('pa', 'Delaware', 'Aldan Borough', 4204500676),
    ('pa', 'Montgomery', 'Ambler Borough', 4209102264),
    ('pa', 'Delaware', 'Aston Township', 4204503336),
    ('pa', 'Chester', 'Atglen Borough', 4202903384),
    ('nj', 'Camden', 'Audubon Borough', 3400702200),
    ('nj', 'Camden', 'Audubon Park Borough', 3400702230),
    ('pa', 'Chester', 'Avondale Borough', 4202903656),
    ('nj', 'Camden', 'Barrington Borough', 3400703250),
    ('nj', 'Burlington', 'Bass River Township', 3400503370),
    ('pa', 'Bucks', 'Bedminster Township', 4201704976),
    ('nj', 'Camden', 'Bellmawr Borough', 3400704750),
    ('pa', 'Bucks', 'Bensalem Township', 4201705616),
    ('nj', 'Camden', 'Berlin Borough', 3400705440),
    ('nj', 'Camden', 'Berlin Township', 3400705470),
    ('pa', 'Delaware', 'Bethel Township', 4204506024),
    ('nj', 'Burlington', 'Beverly City', 3400505740),
    ('pa', 'Chester', 'Birmingham Township', 4202906544),
    ('nj', 'Burlington', 'Bordentown City', 3400506670),
    ('nj', 'Burlington', 'Bordentown Township', 3400506700),
    ('pa', 'Montgomery', 'Bridgeport Borough', 4209108568),
    ('pa', 'Bucks', 'Bridgeton Township', 4201708592),
    ('pa', 'Bucks', 'Bristol Borough', 4201708760),
    ('pa', 'Bucks', 'Bristol Township', 4201708768),
    ('pa', 'Delaware', 'Brookhaven Borough', 4204509080),
    ('nj', 'Camden', 'Brooklawn Borough', 3400708170),
    ('pa', 'Montgomery', 'Bryn Athyn Borough', 4209109696),
    ('pa', 'Bucks', 'Buckingham Township', 4201709816),
    ('nj', 'Burlington', 'Burlington City', 3400508920),
    ('nj', 'Burlington', 'Burlington Township', 3400508950),
    ('pa', 'Chester', 'Caln Township', 4202910824),
    ('nj', 'Camden', 'Camden City', 3400710000),
    ('pa', 'Philadelphia', 'Central', 4210160003),
    ('pa', 'Philadelphia', 'Central Northeast', 4210160018),
    ('pa', 'Delaware', 'Chadds Ford Township', 4204512442),
    ('pa', 'Bucks', 'Chalfont Borough', 4201712504),
    ('pa', 'Chester', 'Charlestown Township', 4202912744),
    ('pa', 'Montgomery', 'Cheltenham Township', 4209112968),
    ('nj', 'Camden', 'Cherry Hill Township', 3400712280),
    ('nj', 'Camden', 'Chesilhurst Borough', 3400712550),
    ('pa', 'Delaware', 'Chester City', 4204513208),
    ('pa', 'Delaware', 'Chester Heights Borough', 4204513232),
    ('pa', 'Delaware', 'Chester Township', 4204513212),
    ('nj', 'Burlington', 'Chesterfield Township', 3400512670),
    ('nj', 'Burlington', 'Cinnaminson Township', 3400512940),
    ('nj', 'Gloucester', 'Clayton Borough', 3401513360),
    ('nj', 'Camden', 'Clementon Borough', 3400713420),
    ('pa', 'Delaware', 'Clifton Heights Borough', 4204514264),
    ('pa', 'Chester', 'Coatesville City', 4202914712),
    ('pa', 'Montgomery', 'Collegeville Borough', 4209115192),
    ('pa', 'Delaware', 'Collingdale Borough', 4204515232),
    ('nj', 'Camden', 'Collingswood Borough', 3400714260),
    ('pa', 'Delaware', 'Colwyn Borough', 4204515432),
    ('pa', 'Delaware', 'Concord Township', 4204515488),
    ('pa', 'Montgomery', 'Conshohocken Borough', 4209115848),
    ('pa', 'Delaware', 'Darby Borough', 4204518152),
    ('pa', 'Delaware', 'Darby Township', 4204518160),
    ('nj', 'Burlington', 'Delanco Township', 3400517080),
    ('nj', 'Burlington', 'Delran Township', 3400517440),
    ('nj', 'Gloucester', 'Deptford Township', 3401517710),
    ('pa', 'Montgomery', 'Douglass Township', 4209119672),
    ('pa', 'Chester', 'Downingtown Borough', 4202919752),
    ('pa', 'Bucks', 'Doylestown Borough', 4201719784),
    ('pa', 'Bucks', 'Doylestown Township', 4201719792),
    ('pa', 'Bucks', 'Dublin Borough', 4201720104),
    ('pa', 'Bucks', 'Durham Township', 4201720480),
    ('pa', 'Chester', 'East Bradford Township', 4202920824),
    ('pa', 'Chester', 'East Brandywine Township', 4202920864),
    ('pa', 'Chester', 'East Caln Township', 4202920920),
    ('pa', 'Chester', 'East Coventry Township', 4202921008),
    ('pa', 'Chester', 'East Fallowfield Township', 4202921104),
    ('pa', 'Chester', 'East Goshen Township', 4202921192),
    ('pa', 'Montgomery', 'East Greenville Borough', 4209121200),
    ('nj', 'Gloucester', 'East Greenwich Township', 3401519180),
    ('pa', 'Delaware', 'East Lansdowne Borough', 4204521384),
    ('pa', 'Chester', 'East Marlborough Township', 4202921480),
    ('pa', 'Chester', 'East Nantmeal Township', 4202921576),
    ('pa', 'Montgomery', 'East Norriton Township', 4209121600),
    ('pa', 'Chester', 'East Nottingham Township', 4202921624),
    ('pa', 'Chester', 'East Pikeland Township', 4202921696),
    ('pa', 'Bucks', 'East Rockhill Township', 4201721760),
    ('pa', 'Chester', 'East Vincent Township', 4202922000),
    ('pa', 'Chester', 'East Whiteland Township', 4202922056),
    ('nj', 'Mercer', 'East Windsor Township', 3402119780),
    ('nj', 'Burlington', 'Eastampton Township', 3400518790),
    ('pa', 'Chester', 'Easttown Township', 4202921928),
    ('pa', 'Delaware', 'Eddystone Borough', 4204522296),
    ('nj', 'Burlington', 'Edgewater Park Township', 3400520050),
    ('pa', 'Delaware', 'Edgmont Township', 4204522584),
    ('pa', 'Chester', 'Elk Township',  4202923032),
    ('nj', 'Gloucester', 'Elk Township', 3401521060),
    ('pa', 'Chester', 'Elverson Borough', 4202923440),
    ('nj', 'Burlington', 'Evesham Township', 3400522110),
    ('nj', 'Mercer', 'Ewing Township', 3402122185),
    ('pa', 'Bucks', 'Falls Township', 4201725112),
    ('nj', 'Burlington', 'Fieldsboro Borough', 3400523250),
    ('nj', 'Burlington', 'Florence Township', 3400523850),
    ('pa', 'Delaware', 'Folcroft Borough', 4204526408),
    ('pa', 'Montgomery', 'Franconia Township', 4209127280),
    ('pa', 'Chester', 'Franklin Township', 4202927376),
    ('nj', 'Gloucester', 'Franklin Township',  3401524840),
    ('nj', 'Camden', 'Gibbsboro Borough', 3400726070),
    ('nj', 'Gloucester', 'Glassboro Borough', 3401526340),
    ('pa', 'Delaware', 'Glenolden Borough', 4204529720),
    ('nj', 'Camden', 'Gloucester City', 3400726820),
    ('nj', 'Camden', 'Gloucester Township', 3400726760),
    ('pa', 'Montgomery', 'Green Lane Borough', 4209131088),
    ('nj', 'Gloucester', 'Greenwich Township', 3401528185),
    ('nj', 'Camden', 'Haddon Heights Borough', 3400728800),
    ('nj', 'Camden', 'Haddon Township', 3400728740),
    ('nj', 'Camden', 'Haddonfield Borough', 3400728770),
    ('nj', 'Burlington', 'Hainesport Township', 3400529010),
    ('nj', 'Mercer', 'Hamilton Township', 3402129310),
    ('nj', 'Gloucester', 'Harrison Township', 3401530180),
    ('pa', 'Montgomery', 'Hatboro Borough', 4209133088),
    ('pa', 'Montgomery', 'Hatfield Borough', 4209133112),
    ('pa', 'Montgomery', 'Hatfield Township', 4209133120),
    ('pa', 'Delaware', 'Haverford Township', 4204533144),
    ('pa', 'Bucks', 'Haycock Township', 4201733224),
    ('nj', 'Camden', 'Hi-Nella Borough', 3400732220),
    ('pa', 'Chester', 'Highland Township', 4202934448),
    ('nj', 'Mercer', 'Hightstown Borough', 3402131620),
    ('pa', 'Bucks', 'Hilltown Township', 4201734952),
    ('pa', 'Chester', 'Honey Brook Borough', 4202935528),
    ('pa', 'Chester', 'Honey Brook Township', 4202935536),
    ('nj', 'Mercer', 'Hopewell Borough', 3402133150),
    ('nj', 'Mercer', 'Hopewell Township', 3402133180),
    ('pa', 'Montgomery', 'Horsham Township', 4209135808),
    ('pa', 'Bucks', 'Hulmeville Borough', 4201736192),
    ('pa', 'Bucks', 'Ivyland Borough', 4201737304),
    ('pa', 'Montgomery', 'Jenkintown Borough', 4209138000),
    ('pa', 'Chester', 'Kennett Square Borough', 4202939352),
    ('pa', 'Chester', 'Kennett Township', 4202939344),
    ('pa', 'Bucks', 'Langhorne Borough', 4201741392),
    ('pa', 'Bucks', 'Langhorne Manor Borough', 4201741416),
    ('pa', 'Montgomery', 'Lansdale Borough', 4209141432),
    ('pa', 'Delaware', 'Lansdowne Borough', 4204541440),
    ('nj', 'Camden', 'Laurel Springs Borough', 3400739210),
    ('nj', 'Camden', 'Lawnside Borough', 3400739420),
    ('nj', 'Mercer', 'Lawrence Township', 3402139510),
    ('pa', 'Montgomery', 'Limerick Township', 4209143312),
    ('nj', 'Camden', 'Lindenwold Borough', 3400740440),
    ('nj', 'Gloucester', 'Logan Township', 3401541160),
    ('pa', 'Chester', 'London Britain Township', 4202944440),
    ('pa', 'Chester', 'London Grove Township', 4202944480),
    ('pa', 'Chester', 'Londonderry Township', 4202944456),
    ('pa', 'Delaware', 'Lower Chichester Township', 4204544888),
    ('pa', 'Philadelphia', 'Lower Far Northeast', 4210160016),
    ('pa', 'Montgomery', 'Lower Frederick Township', 4209144912),
    ('pa', 'Montgomery', 'Lower Gwynedd Township', 4209144920),
    ('pa', 'Bucks', 'Lower Makefield Township', 4201744968),
    ('pa', 'Montgomery', 'Lower Merion Township', 4209144976),
    ('pa', 'Montgomery', 'Lower Moreland Township', 4209145008),
    ('pa', 'Philadelphia', 'Lower North', 4210160007),
    ('pa', 'Philadelphia', 'Lower Northeast', 4210160014),
    ('pa', 'Philadelphia', 'Lower Northwest', 4210160008),
    ('pa', 'Chester', 'Lower Oxford Township', 4202945040),
    ('pa', 'Montgomery', 'Lower Pottsgrove Township', 4209145072),
    ('pa', 'Montgomery', 'Lower Providence Township', 4209145080),
    ('pa', 'Montgomery', 'Lower Salford Township', 4209145096),
    ('pa', 'Philadelphia', 'Lower South', 4210160005),
    ('pa', 'Bucks', 'Lower Southampton Township', 4201745112),
    ('pa', 'Philadelphia', 'Lower Southwest', 4210160002),
    ('nj', 'Burlington', 'Lumberton Township', 3400542060),
    ('nj', 'Camden', 'Magnolia Borough', 3400742630),
    ('pa', 'Chester', 'Malvern Borough', 4202946792),
    ('nj', 'Burlington', 'Mansfield Township', 3400543290),
    ('nj', 'Gloucester', 'Mantua Township', 3401543440),
    ('nj', 'Burlington', 'Maple Shade Township', 3400543740),
    ('pa', 'Delaware', 'Marcus Hook Borough', 4204547344),
    ('pa', 'Montgomery', 'Marlborough Township', 4209147592),
    ('pa', 'Delaware', 'Marple Township', 4204547616),
    ('nj', 'Burlington', 'Medford Lakes Borough', 3400545210),
    ('nj', 'Burlington', 'Medford Township', 3400545120),
    ('pa', 'Delaware', 'Media Borough', 4204548480),
    ('nj', 'Camden', 'Merchantville Borough', 3400745510),
    ('pa', 'Bucks', 'Middletown Township', 4201749120),
    ('pa', 'Delaware', 'Middletown Township', 4204549136),
    ('pa', 'Bucks', 'Milford Township', 4201749384),
    ('pa', 'Delaware', 'Millbourne Borough', 4204549504),
    ('pa', 'Chester', 'Modena Borough', 4202950232),
    ('nj', 'Gloucester', 'Monroe Township', 3401547250),
    ('pa', 'Montgomery', 'Montgomery Township', 4209150640),
    ('nj', 'Burlington', 'Moorestown Township', 3400547880),
    ('pa', 'Bucks', 'Morrisville Borough', 4201751144),
    ('pa', 'Delaware', 'Morton Borough', 4204551176),
    ('nj', 'Camden', 'Mount Ephraim Borough', 3400748750),
    ('nj', 'Burlington', 'Mount Holly Township', 3400548900),
    ('nj', 'Burlington', 'Mount Laurel Township', 3400549020),
    ('pa', 'Montgomery', 'Narberth Borough', 4209152664),
    ('nj', 'Gloucester', 'National Park Borough', 3401549680),
    ('pa', 'Delaware', 'Nether Providence Township', 4204553104),
    ('pa', 'Bucks', 'New Britain Borough', 4201753296),
    ('pa', 'Bucks', 'New Britain Township', 4201753304),
    ('pa', 'Chester', 'New Garden Township', 4202953608),
    ('nj', 'Burlington', 'New Hanover Township', 3400551510),
    ('pa', 'Montgomery', 'New Hanover Township', 4209153664),
    ('pa', 'Bucks', 'New Hope Borough', 4201753712),
    ('pa', 'Chester', 'New London Township', 4202953816),
    ('nj', 'Gloucester', 'Newfield Borough', 3401551390),
    ('pa', 'Chester', 'Newlin Township', 4202953784),
    ('pa', 'Bucks', 'Newtown Borough', 4201754184),
    ('pa', 'Bucks', 'Newtown Township', 4201754192),
    ('pa', 'Delaware', 'Newtown Township', 4204554224),
    ('pa', 'Bucks', 'Nockamixon Township', 4201754576),
    ('pa', 'Montgomery', 'Norristown Borough', 4209154656),
    ('pa', 'Philadelphia', 'North', 4210160001),
    ('pa', 'Chester', 'North Coventry Township', 4202954936),
    ('pa', 'Philadelphia', 'North Delaware', 4210160004),
    ('nj', 'Burlington', 'North Hanover Township', 3400553070),
    ('pa', 'Montgomery', 'North Wales Borough', 4209155512),
    ('pa', 'Bucks', 'Northampton Township', 4201754688),
    ('pa', 'Delaware', 'Norwood Borough', 4204555664),
    ('nj', 'Camden', 'Oaklyn Borough', 3400753880),
    ('pa', 'Chester', 'Oxford Borough', 4202957480),
    ('nj', 'Burlington', 'Palmyra Borough', 3400555800),
    ('pa', 'Chester', 'Parkesburg Borough', 4202958032),
    ('pa', 'Delaware', 'Parkside Borough', 4204558176),
    ('nj', 'Gloucester', 'Paulsboro Borough', 3401557150),
    ('nj', 'Burlington', 'Pemberton Borough', 3400557480),
    ('nj', 'Burlington', 'Pemberton Township', 3400557510),
    ('pa', 'Chester', 'Penn Township', 4202958808),
    ('pa', 'Bucks', 'Penndel Borough', 4201758936),
    ('nj', 'Mercer', 'Pennington Borough', 3402157600),
    ('nj', 'Camden', 'Pennsauken Township', 3400757660),
    ('pa', 'Montgomery', 'Pennsburg Borough', 4209159120),
    ('pa', 'Chester', 'Pennsbury Township', 4202959136),
    ('pa', 'Bucks', 'Perkasie Borough', 4201759384),
    ('pa', 'Montgomery', 'Perkiomen Township', 4209159392),
    ('pa', 'Philadelphia', 'Philadelphia City', 4210160000),
    ('pa', 'Chester', 'Phoenixville Borough', 4202960120),
    ('nj', 'Camden', 'Pine Hill Borough', 3400758770),
    ('nj', 'Camden', 'Pine Valley Borough', 3400758920),
    ('nj', 'Gloucester', 'Pitman Borough', 3401559070),
    ('pa', 'Bucks', 'Plumstead Township', 4201761616),
    ('pa', 'Montgomery', 'Plymouth Township', 4209161664),
    ('pa', 'Chester', 'Pocopson Township', 4202961800),
    ('pa', 'Montgomery', 'Pottstown Borough', 4209162416),
    ('nj', 'Mercer', 'Princeton', 3402160900),
    ('pa', 'Delaware', 'Prospect Park Borough', 4204562792),
    ('pa', 'Bucks', 'Quakertown Borough', 4201763048),
    ('pa', 'Delaware', 'Radnor Township', 4204563264),
    ('pa', 'Montgomery', 'Red Hill Borough', 4209163808),
    ('pa', 'Bucks', 'Richland Township', 4201764536),
    ('pa', 'Bucks', 'Richlandtown Borough', 4201764584),
    ('pa', 'Delaware', 'Ridley Park Borough', 4204564832),
    ('pa', 'Delaware', 'Ridley Township', 4204564800),
    ('pa', 'Bucks', 'Riegelsville Borough', 4201764856),
    ('pa', 'Philadelphia', 'River Wards', 4210160009),
    ('nj', 'Burlington', 'Riverside Township', 3400563510),
    ('nj', 'Burlington', 'Riverton Borough', 3400563660),
    ('nj', 'Mercer', 'Robbinsville Township', 3402163850),
    ('pa', 'Montgomery', 'Rockledge Borough', 4209165568),
    ('pa', 'Delaware', 'Rose Valley Borough', 4204566192),
    ('pa', 'Montgomery', 'Royersford Borough', 4209166576),
    ('nj', 'Camden', 'Runnemede Borough', 3400765160),
    ('pa', 'Delaware', 'Rutledge Borough', 4204566928),
    ('pa', 'Chester', 'Sadsbury Township', 4202967080),
    ('pa', 'Montgomery', 'Salford Township', 4209167528),
    ('pa', 'Chester', 'Schuylkill Township', 4202968288),
    ('pa', 'Montgomery', 'Schwenksville Borough', 4209168328),
    ('pa', 'Bucks', 'Sellersville Borough', 4201769248),
    ('nj', 'Burlington', 'Shamong Township', 3400566810),
    ('pa', 'Delaware', 'Sharon Hill Borough', 4204569752),
    ('pa', 'Bucks', 'Silverdale Borough', 4201770744),
    ('pa', 'Montgomery', 'Skippack Township', 4209171016),
    ('pa', 'Bucks', 'Solebury Township', 4201771752),
    ('nj', 'Camden', 'Somerdale Borough', 3400768340),
    ('pa', 'Montgomery', 'Souderton Borough', 4209171856),
    ('pa', 'Philadelphia', 'South', 4210160012),
    ('pa', 'Chester', 'South Coatesville Borough', 4202972072),
    ('pa', 'Chester', 'South Coventry Township', 4202972088),
    ('nj', 'Gloucester', 'South Harrison Township', 3401569030),
    ('nj', 'Burlington', 'Southampton Township', 3400568610),
    ('pa', 'Chester', 'Spring City Borough', 4202972920),
    ('pa', 'Bucks', 'Springfield Township', 4201773016),
    ('nj', 'Burlington', 'Springfield Township', 3400569990),
    ('pa', 'Delaware', 'Springfield Township', 4204573032),
    ('pa', 'Montgomery', 'Springfield Township', 4209173088),
    ('nj', 'Camden', 'Stratford Borough', 3400771220),
    ('pa', 'Delaware', 'Swarthmore Borough', 4204575648),
    ('nj', 'Gloucester', 'Swedesboro Borough', 3401571850),
    ('nj', 'Burlington', 'Tabernacle Township', 3400572060),
    ('nj', 'Camden', 'Tavistock Borough', 3400772240),
    ('pa', 'Bucks', 'Telford Borough', 4201776304),
    ('pa', 'Montgomery', 'Telford Borough', 4209176304),
    ('pa', 'Chester', 'Thornbury Township', 4202976568),
    ('pa', 'Delaware', 'Thornbury Township', 4204576576),
    ('pa', 'Bucks', 'Tinicum Township', 4201776784),
    ('pa', 'Delaware', 'Tinicum Township', 4204576792),
    ('pa', 'Montgomery', 'Towamencin Township', 4209177152),
    ('pa', 'Delaware', 'Trainer Borough', 4204577288),
    ('pa', 'Montgomery', 'Trappe Borough', 4209177304),
    ('pa', 'Chester', 'Tredyffrin Township', 4202977344),
    ('nj', 'Mercer', 'Trenton City', 3402174000),
    ('pa', 'Bucks', 'Trumbauersville Borough', 4201777704),
    ('pa', 'Bucks', 'Tullytown Borough', 4201777744),
    ('pa', 'Philadelphia', 'University/Southwest', 4210160010),
    ('pa', 'Delaware', 'Upland Borough', 4204578712),
    ('pa', 'Delaware', 'Upper Chichester Township', 4204578776),
    ('pa', 'Delaware', 'Upper Darby Township', 4204579000),
    ('pa', 'Montgomery', 'Upper Dublin Township', 4209179008),
    ('pa', 'Philadelphia', 'Upper Far Northeast', 4210160013),
    ('pa', 'Montgomery', 'Upper Frederick Township', 4209179040),
    ('pa', 'Montgomery', 'Upper Gwynedd Township', 4209179056),
    ('pa', 'Montgomery', 'Upper Hanover Township', 4209179064),
    ('pa', 'Bucks', 'Upper Makefield Township', 4201779128),
    ('pa', 'Montgomery', 'Upper Merion Township', 4209179136),
    ('pa', 'Montgomery', 'Upper Moreland Township', 4209179176),
    ('pa', 'Philadelphia', 'Upper North', 4210160015),
    ('pa', 'Philadelphia', 'Upper Northwest', 4210160017),
    ('pa', 'Chester', 'Upper Oxford Township', 4202979208),
    ('pa', 'Montgomery', 'Upper Pottsgrove Township', 4209179240),
    ('pa', 'Delaware', 'Upper Providence Township', 4204579248),
    ('pa', 'Montgomery', 'Upper Providence Township', 4209179256),
    ('pa', 'Montgomery', 'Upper Salford Township', 4209179280),
    ('pa', 'Bucks', 'Upper Southampton Township', 4201779296),
    ('pa', 'Chester', 'Upper Uwchlan Township', 4202979352),
    ('pa', 'Chester', 'Uwchlan Township', 4202979480),
    ('pa', 'Chester', 'Valley Township', 4202979544),
    ('nj', 'Camden', 'Voorhees Township', 3400776220),
    ('pa', 'Chester', 'Wallace Township', 4202980616),
    ('pa', 'Bucks', 'Warminster Township', 4201780952),
    ('pa', 'Bucks', 'Warrington Township', 4201781048),
    ('pa', 'Bucks', 'Warwick Township', 4201781144),
    ('pa', 'Chester', 'Warwick Township', 4202981160),
    ('nj', 'Burlington', 'Washington Township', 3400577150),
    ('nj', 'Gloucester', 'Washington Township', 3401577180),
    ('nj', 'Camden', 'Waterford Township', 3400777630),
    ('nj', 'Gloucester', 'Wenonah Borough', 3401578110),
    ('pa', 'Philadelphia', 'West', 4210160011),
    ('pa', 'Chester', 'West Bradford Township', 4202982544),
    ('pa', 'Chester', 'West Brandywine Township', 4202982576),
    ('pa', 'Chester', 'West Caln Township', 4202982664),
    ('pa', 'Chester', 'West Chester Borough', 4202982704),
    ('pa', 'Montgomery', 'West Conshohocken Borough', 4209182736),
    ('nj', 'Gloucester', 'West Deptford Township', 3401578800),
    ('pa', 'Chester', 'West Fallowfield Township', 4202982936),
    ('pa', 'Chester', 'West Goshen Township', 4202983080),
    ('pa', 'Chester', 'West Grove Borough', 4202983104),
    ('pa', 'Chester', 'West Marlborough Township', 4202983464),
    ('pa', 'Chester', 'West Nantmeal Township', 4202983664),
    ('pa', 'Montgomery', 'West Norriton Township', 4209183696),
    ('pa', 'Chester', 'West Nottingham Township', 4202983712),
    ('pa', 'Philadelphia', 'West Park', 4210160006),
    ('pa', 'Chester', 'West Pikeland Township', 4202983832),
    ('pa', 'Montgomery', 'West Pottsgrove Township', 4209183912),
    ('pa', 'Bucks', 'West Rockhill Township', 4201783960),
    ('pa', 'Chester', 'West Sadsbury Township', 4202983968),
    ('pa', 'Chester', 'West Vincent Township', 4202984160),
    ('pa', 'Chester', 'West Whiteland Township', 4202984192),
    ('nj', 'Mercer', 'West Windsor Township', 3402180240),
    ('nj', 'Burlington', 'Westampton Township', 3400578200),
    ('pa', 'Chester', 'Westtown Township', 4202984104),
    ('nj', 'Gloucester', 'Westville Borough', 3401580120),
    ('pa', 'Montgomery', 'Whitemarsh Township', 4209184624),
    ('pa', 'Montgomery', 'Whitpain Township', 4209184888),
    ('nj', 'Burlington', 'Willingboro Township', 3400581440),
    ('pa', 'Chester', 'Willistown Township', 4202985352),
    ('nj', 'Camden', 'Winslow Township', 3400781740),
    ('nj', 'Gloucester', 'Woodbury City', 3401582120),
    ('nj', 'Gloucester', 'Woodbury Heights Borough', 3401582180),
    ('nj', 'Burlington', 'Woodland Township', 3400582420),
    ('nj', 'Camden', 'Woodlynne Borough', 3400782450),
    ('nj', 'Gloucester', 'Woolwich Township', 3401582840),
    ('pa', 'Montgomery', 'Worcester Township', 4209186496),
    ('nj', 'Burlington', 'Wrightstown Borough', 3400582960),
    ('pa', 'Bucks', 'Wrightstown Township', 4201786624),
    ('pa', 'Bucks', 'Yardley Borough', 4201786920),
    ('pa', 'Delaware', 'Yeadon Borough', 4204586968);

COMMIT;
