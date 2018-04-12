/* First page of app for logging in and creating StudyBuddy account.
* TODO: -styling
*       -link it to Server
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

import CreateUser from './CreateUser';
import Settings from './Settings';
import GroupPage from './GroupPage';
import NewGroupA from './NewGroupA';
import styles from './stylings';
import {dictVars} from './globals.js';

export default class Login extends Component<{}> {
  constructor(){
    super()
    this.state = {
      username: '',
      password: '',
    }
  }
  _handleLoginPress() {
    let form = new FormData();
    form.append('email', this.state.username);
    form.append('password', this.state.password);
    fetch('http://34.214.169.181:5000/login', {
    method: 'POST',
    body: form,
    }).then(response => response.json())
      .then((responseJson) => {
        let token = responseJson[1]['token']
        global.SESSION_TOKEN = token;
      })
      .catch(error =>
        this.setState({
          isLoading: false,
          message: 'Something went wrong: ' + error
        }));

  }

  render() {
    return (

      <View style={styles.container}>

      <Text style={styles.description}>
      Welcome to StudyBuddy!
      </Text>

      <Text style={styles.description}>
      Enter your information below:
      </Text>

      <View>

      <Text style={styles.description}>
      Email:
      </Text>

      <TextInput
      style={styles.searchInput}
      placeholder='     '
      returnKeyType = {"next"}
      onChangeText={(text) => this.setState({username:text})}
      autoCapitalize='none'
      />

      </View>

      <View>

      <Text style={styles.description}>
      Password:
      </Text>

      <TextInput
      style={styles.searchInput}
      placeholder='     '
      returnKeyType = {"next"}
      onChangeText={(text) => this.setState({password:text})}
      autoCapitalize='none'
      />

    </View>

      <View style={styles.buttons}>

      <Button
      color = '#1E1E46'
      onPress={() => this._handleLoginPress()}
      title = "Login">
      </Button>

      </View>

      <View style={styles.buttons}>

      <Button
      color = '#1E1E46'
      onPress={() => this.props.navigation.navigate('CreateUser')}
      title = "Create Account">
      </Button>

      </View>

      <View style={styles.buttons}>

      <Button
      onPress={() => this.props.navigation.navigate('Settings')}
      title = "Settings (for debugging)">
      </Button>

      </View>

      <View style={styles.buttons}>

      <Button
      onPress={() => this.props.navigation.navigate('GroupPage')}
      title = "Group Page (for debugging)">
      </Button>

      </View>

      <View style={styles.buttons}>

      <Button
      onPress={() => this.props.navigation.navigate('ClassPage')}
      title = "Class Page (for debugging)">
      </Button>

      </View>

      <View style={styles.buttons}>

      <Button
      onPress={() => this.props.navigation.navigate('NewGroupA')}
      title = "Create New Group (for debugging)">
      </Button>

      </View>

      </View>
    );
  }
}
