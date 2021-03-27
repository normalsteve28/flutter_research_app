//Dart file that contains list of systolic, diastolic, heart rate
// Is NOT final data source for BP and heart rate, only a temporary placeholder
/* 
The history boxes code make boxes starting from the first index.
However, the history boxes are expected to show the newest data first.
Lists usually add newer data at the last.
Therefore, for these history boxes to show the most recent data, the newer data
should be added at the FRONT instead.
*/

List<int> sys = [];
List<int> dia = [];
List<int> heartRate = [];
bool dataIsEqualNotEmpty = (sys.length > 0 &&
    dia.length > 0 &&
    heartRate.length > 0 &&
    sys.length == dia.length &&
    dia.length == heartRate.length);
