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
import styles from './stylings';
export default class Login extends Component<{}> {
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

    render() {
	return (

		<View style={styles.container}>
		<Text style={styles.description}>
		Welcome to StudyBuddy!
            </Text>

		<Text style={styles.description}>
		Enter your information below:
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

		<View style={styles.buttons}>
		<Button
            onPress={() => this._handlePress()} 
            title = "Login">
		</Button>
		</View>
		
		<View style={styles.buttons}>
		<Button 
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
		</View>

	    </View>
	);
    }
}
