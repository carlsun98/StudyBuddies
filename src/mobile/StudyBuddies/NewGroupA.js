/* First page of create group flow. Asks for course user wants to
 * make the group for.
 * TODO: -styling
 *       -link it to school's courses
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
import NewGroupB from './NewGroupB';
import styles from './stylings';

export default class NewGroupA extends Component<{}> {
    constructor(){
	super()
	this.state = {
            groupClass: '',
	}
    }
    _handlePress() {
	console.log(this.state.groupClass);
	this.props.navigation.navigate('NewGroupB')
    }

    render() {
	return (
              <View style={styles.container}>
		<Text style={styles.description}>
		  You Are Making a New Group!
                </Text>

		<Text style={styles.description}>
		  What class do you want to make a group for?
                </Text>

  	 	<TextInput 
    	          style={styles.searchInput}
    	          placeholder='     '
    	          returnKeyType = {"next"}
 	          onChangeText={(text) => this.setState({groupClass:text})}
    		/>

		<View style={styles.buttons}>
		  <Button
                    onPress={() => this._handlePress()}
	            color = '#1E1E46'
                    title = "Next Step">
		  </Button>
		</View>
	      </View>
	);
    }
}
