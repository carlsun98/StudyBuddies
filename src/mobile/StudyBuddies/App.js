'use strict';
import React, { Component } from 'react';
import { StackNavigator } from 'react-navigation'; 
import {
  Platform,
  StyleSheet,
  Text,
  View,
  NavigatorIOS,
} from 'react-native';
import SearchPage from './SearchPage';
import CreateUser from './CreateUser';
import AwaitingConfirmation from './AwaitingConfirmation';
import Settings from './Settings';

/* const App = StackNavigator({
  Home: {screen: SearchPage },
}) */

const RootStack = StackNavigator(
 {
  SearchPage: {
    screen: SearchPage,
  },
  CreateUser: {
    screen: CreateUser,
  },
  AwaitingConfirmation: {
    screen: AwaitingConfirmation,
  },
  Settings: {
    screen: Settings,
  }
 },
 {
  initialRouteName: 'SearchPage',
 }
);
export default class App extends Component <{}> {
  render() {
    return <RootStack />;
  }
}

/*class CreateUser extends Component <{}> {
  render() {
    return (
      <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
        <Text>Details Screen</Text>
      </View>
    );
  }
} */
/*export default StackNavigator({
  Home: {
    screen: SearchPage,
  },
}); */

/*e xport default class App extends Component <{}> {
  render() {
    return (
      <NavigatorIOS
        style={{flex: 1}}
        initialRoute={{
          component: SearchPage,
          title: 'My Initial Scene',
        }}
      />
    );
  }
} */

/* class SearchPage extends Component<{}> {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.description}>
          Search for houses to buy!
        </Text>
        <Text style={styles.description}>
          Search by place-name or postcode.
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  description: {
    marginBottom: 20,
    fontSize: 18,
    textAlign: 'center',
    color: '#656565'
  },
  container: {
    padding: 30,
    marginTop: 65,
    alignItems: 'center'
  },
});
*/
