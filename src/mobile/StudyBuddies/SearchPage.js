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

export default class SearchPage extends Component<{}> {

	constructor(){
    super()
    this.state = {
      username: '',
      password: '',
    }
  }
    _handlePress() {
     console.log(this.state.username);
     console.log(this.state.password);
  }

 /*  _makeAccountPress() {
  	navigation.navigate('NewUser')
  } */
  	   // const { navigate } = this.props.navigation;

  render() {

    return (
      <View style={styles.container}>

        <Text style={styles.description}>
          Welcome to StudyBuddy!
        </Text>

        <Text style={styles.description}>
        	Insert your information below:
        </Text>

        <View style={styles.inputBoxes}>
        <View style={{flexDirection: 'row'}}>
         <Text>
            Email:
        </Text>

  		<TextInput 
    	style={styles.searchInput}
    	placeholder='     '
    	returnKeyType = {"next"}
 		onChangeText={(text) => this.setState({username:text})}
    	/>
    	</View>

  		 <View style={{flexDirection: 'row'}}>
         	<Text>
            Password:
          	</Text>

  		<TextInput 
    	style={styles.searchInput}
    	placeholder='     '
    	returnKeyType = {"next"}
 		onChangeText={(text) => this.setState({password:text})}
    	/>
		</View>

        <Button
          onPress={() => this._handlePress()} 
          title = "Login">
        </Button>

        <Button 
        onPress={() => this.props.navigation.navigate('CreateUser')}
        title = "Create Account">
        </Button>

        <Button 
        onPress={() => this.props.navigation.navigate('Settings')}
        title = "Settings (for debugging)">
        </Button>

		</View>

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

   descriptionAsk: {
    marginBottom: 20,
    fontSize: 18,
    textAlign: 'left',
    color: '#656565'
  },

  container: {
    padding: 30,
    marginTop: 65,
    flex: 1
  },
  inputBoxes: {
  flexDirection: 'column',
  alignItems: 'center',
  padding: 10
},
searchInput: {
  height: 36,
  padding: 4,
  marginRight: 5,
  marginLeft: 5,
  fontSize: 18,
  borderWidth: 1,
  borderColor: '#48BBEC',
  borderRadius: 8,
  color: '#48BBEC',
},
});
