/* Third page of create group flow. Needs to allow user to choose
 * how long the group will (initially) exist for before being
 * automatically disbanded. 
 * TODO: -styling
 *       -proper setup of time choosing
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
import NewGroupD from './NewGroupD'
import styles from './stylings';

export default class NewGroupC extends Component<{}> {
    constructor(){
	super()
	this.state = {
            groupHours: '',
            groupMinutes: '',
	}
    }
    _handlePress() {
	console.log(this.state.groupHours);
    console.log(this.state.groupMinutes);
	this.props.navigation.navigate('NewGroupD')
    }

    render() {
	return (
              <View style={styles.container}>
		<Text style={styles.description}>
		  You Are Making a New Group!
                </Text>

	        <Text style={styles.description}>
		  About how long will you study for?
                </Text>

                <View style={{flexDirection: 'row'}}>
                  <Text style={styles.description}>
                    Hours:
                  </Text>

                  <TextInput 
                    style={styles.searchInput}
                    placeholder='     '
                    returnKeyType = {"next"}
                    onChangeText={(text) => this.setState({groupHours:text})}
                  />
                </View>

                <View style={{flexDirection: 'row'}}>
                  <Text style={styles.description}>
                    Minutes:
                  </Text>

                  <TextInput 
                    style={styles.searchInput}
                    placeholder='     '
                    returnKeyType = {"next"}
                    onChangeText={(text) => this.setState({groupMinutes:text})}
                  />
                </View>
           
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

