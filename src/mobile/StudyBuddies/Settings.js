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
	this.state.classes.splice(i,1);
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

			<Button
		    onPress={() => this._handleDelPress(item)} 
		    title = "Del">
			</Button> 

		    </View>
			
		))}

		<Text style={styles.description}>
		Add Courses:
            </Text>
		
		<Button
            onPress={() => this._handleAddClassPress()} 
            title = "Add the Selected Course To My List">
		</Button> 

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
