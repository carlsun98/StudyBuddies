/* First page of app for logging in and creating StudyBuddy account.
* TODO: -styling
*       -link it to Server
*       -make buttons redirect properly
*******************************************************************/

'use strict';

import React, { Component } from 'react';

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
import CreateUser from './CreateUser';
import Settings from './Settings';
import GroupPage from './GroupPage';

class ListItemView extends React.PureComponent {
  _onPress = () => {
    this.props.onPressItem(this.props.id);
  };

  render() {
    //const textColor = this.props.selected ? "red" : "black";
    return (
      <View></View>
    );
  }
}

export default class ClassPage extends Component<{}> {
  constructor(){
    super()
    //let datastore = new DataStore()
    this.state = {
      username: '',
      password: '',
    }
  }
  static navigationOptions = {
    title: 'Classes',
    tabBarIcon: () => (
      <Image
        style={{width: 26, height: 26}}
        source={require('./assets/tab-icons/classes.png')}
        //style={CommonStyles.tabBarIcon}
      />
    )
  };
  _handleActiveGroupPress() {
    console.log(this.state.username);
    console.log(this.state.password);
  }

  render() {
    return (
      <View style={styles.container}>
      <View style={styles.buttons}>
      <Button
      onPress={() => this._handleActiveGroupPress()}
      title = "Active Groups">
      </Button>
      </View>

      <View style={styles.buttons}>
      <Button
      onPress={() => this.props.navigation.navigate('CreateUser')}
      title = "See Group Locations">
      </Button>
      </View>

      <View style={styles.buttons}>
      <Button
      onPress={() => this.props.navigation.navigate('Settings')}
      title = "Create Group">
      </Button>
      </View>
      </View>
    );
  }
}
