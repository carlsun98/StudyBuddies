/* Page that should show Google Maps screen with pins for each group
 * that currently exists. Centers on student's school's campus.
 * TODO: -styling
 *       -actually make map interactive
 *       -make the map at all
 *******************************************************************/

'use strict';

import React, {
  Component
} from 'react';
import MapView from 'react-native-maps';
import {
  StackNavigator,
} from 'react-navigation';
import {
  StyleSheet,
  Text,
  TextInput,
  View,
  Button,
  ActivityIndicator,
  Image,
} from 'react-native';
import styles from './stylings';

export default class MapPage extends Component < {} > {
  constructor() {
    super()
    this.state = {
      groupClass: '',
    }
  }
  render() {
      return (
	<View style={mapStyle.mapCont}>
          <MapView
	  style={mapStyle.map}
	  initialRegion = {{
            latitude: 37.78825,
            longitude: -122.4324,
            latitudeDelta: 0.0922,
            longitudeDelta: 0.0421,
          }}
	  >
	  </MapView>
        </View>    
    );
  }
}
const mapStyle = StyleSheet.create({
    mapCont: {
	...StyleSheet.absoluteFillObject,
	height: 400,
	width: 400,
	justifyContent: 'flex-end',
	alignItems: 'center',
    },
    map: {
	...StyleSheet.absoluteFillObject,
    },
});
