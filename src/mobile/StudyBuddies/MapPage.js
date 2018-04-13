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
import NewGroupA from './NewGroupA'

export default class MapPage extends Component < {} > {
  constructor() {
    super()
    this.state = {
      groupClass: '',
    }
  }
  static navigationOptions = {
    title: 'Map',
  };
  _handleNewGroupPress() {
    this.props.navigation.navigate('NewGroupA')
  }
  render() {
      return (
        <View style={{
          flex: 1,
          flexDirection: 'column',
          justifyContent: 'space-between',
        }}>

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

        <View>
        <Button
          stype={styles.positionInBottom}
          onPress={() => this._handleNewGroupPress()}
          title = "Create New Group">
          raised = {true}
          theme='dark'
          overrides={true}
        </Button>
        </View>
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
