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
export default class Settings extends Component<{}> {

    constructor(){
	super()
	this.state = {
	    classes : ["COS333", "COS 445"],
	    notifications: true, /* comes from db */
	    all_courses: ["SOC 250", "ANT 225", "ENG 201", "ENG 362", "COS 333", "COS 445"],
	    addedClass: ' '
	}
    }
    updateClasses = (addedClass) => {
	this.setState({addedClass: addedClass})
    }

    _handleAddClassPress() {
	this.state.classes.push(this.state.addedClass);
    }

    _handleDelPress(item) {
	var i = this.state.classes.indexOf(item);
	var removedItem = this.state.classes.splice(i,1);
	console.log(removedItem);
    }

    _handleLogoutPress() {
	this.props.navigation.dispatch(NavigationActions.back());
    }

    render() {

	return (
		<View style={styles.container}>

		<Text style={styles.description}>
		Settings
                </Text>

		<Text style={styles.description}>
		Current Courses:
                </Text>

		<View style={styles.inputBoxes}>

            { 
		this.state.classes.map((item, i) => (

			<View style={{flexDirection: 'row'}}>
			<Text key={i} style={styles.description}> {item} </Text>

		        <View style={styles.buttons}>
			<Button 
		    onPress={() => this._handleDelPress(item)} 
		    title = "Del">
			</Button> 
			</View>
		    </View>
			
		))}

		<Text style={styles.description}>
		Add Courses:
                </Text>
		<View style={styles.buttons}>
		<Button
            onPress={() => this._handleAddClassPress()} 
            title = "Add the Selected Course To My List">
		</Button> 
		</View>
		
	        <View style={styles.buttons}>
		<Button
	    onPress={() => this._handleLogoutPress()}
	    title = "Logout">
		</Button>
	        </View>
		
		<View>
		 <Picker 
            mode = 'dropdown'
            selectedValue = {this.state.addedClass} 
            style={{height: -10, width: 100}} 
            onValueChange = {this.updateClasses}>
		{this.state.all_courses.map((item, index) => {
                    return (< Picker.Item label={item} value={index} key={index} />);
		})} 
            </Picker> 

            </View> 

	    </View>

	    </View>
	);
    }
}

