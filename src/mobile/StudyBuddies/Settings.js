/* Settings page to allow user to delete or add courses they are currently
* enrolled in. Needs access to user's courses and school's courses
* available. Also needs access to whether user wants notifications or not.
* TODO: -styling
*       -add push notifications option
*       -link to DB/server to access courses properly and not use dummy set
***************************************************************************/

'use strict';

import React, { Component } from 'react';

import {
  StackNavigator,
  NavigationActions
} from 'react-navigation';

import {

  StyleSheet,
  Text,
  TextInput,
  View,
  Button,
  ActivityIndicator,
  Image,
  Picker
} from 'react-native';
import styles from './stylings';
// import {dictVars} from './globals.js'
export default class Settings extends Component<{}> {

  constructor(){
    super()
    this.state = {
    /*  classes : ["COS333", "COS 445"],
      all_courses: ["SOC 250", "ANT 225", "ENG 201", "ENG 362", "COS 333", "COS 445"],
      addedClass: 0 */
      notifications: "ON", /* comes from db */
    }
  }
  static navigationOptions = {
    title: 'Settings',
    tabBarIcon: () => (
      <Image
        style={{width: 26, height: 26}}
        source={require('./assets/tab-icons/settings.png')}
        //style={CommonStyles.tabBarIcon}
      />
    )
  };
  updateClasses = (addedClass) => {
    this.setState({addedClass: addedClass})
  }

  _handleAddClassPress() {
    let form = new FormData();
    form.append('class_id', this.state.addedClass);
    form.append('password', this.state.password);
    fetch('http://34.214.169.181:5000/add_class', {
      method: 'POST',
      body: form,
    }).then(response => response.json())
    .then((responseJson) => {
      console.log(responseJson)
    })
    .catch(error =>
      this.setState({
        isLoading: false,
        message: 'Something went wrong: ' + error
      }));
      this.state.classes.push(this.state.all_courses[this.state.addedClass]);
      this.setState({classes: this.state.classes})
    }

    _handleDelPress(item) {
      const newState = this.state.classes.slice();
      if (newState.indexOf(item) > -1) {
        newState.splice(newState.indexOf(item),1);
        this.setState({data: newState})
      }
      var i = this.state.classes.indexOf(item);
      var removedItem = this.state.classes.splice(i,1);
      console.log(removedItem);
    }

    _handleLogoutPress() {
      this.props.navigation.dispatch(NavigationActions.back());
    }

    _handleChangeNPress() {
      if(this.state.notifications == "ON")
        this.setState({notifications: "OFF"})
      if(this.state.notifications == "OFF")
        this.setState({notifications: "ON"})
    }

    render() {

      return (
        <View style={styles.container}>

        <View>
        <Text style={styles.description}>
        Settings
        </Text>

          <Text style={styles.description}>
          Current Notification Settings: {this.state.notifications}
          </Text>
          </View>

          <View style={styles.buttons}>
          <Button
          onPress={() => this._handleChangeNPress()}
          title = "Change notification Settings">
          </Button>

          <Button
          onPress={() => this._handleLogoutPress()}
          title = "Logout">
          </Button>
          </View>

          </View>
        );
      }
    }
