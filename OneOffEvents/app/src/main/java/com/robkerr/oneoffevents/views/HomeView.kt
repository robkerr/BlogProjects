package com.robkerr.oneoffevents.views

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavController
import com.robkerr.oneoffevents.viewmodels.HomeViewModel
import com.robkerr.oneoffevents.viewmodels.HomeViewState
import de.palm.composestateevents.EventEffect

@Composable
fun HomeView(viewModel: HomeViewModel) {


    val viewState: HomeViewState by viewModel.viewState.collectAsStateWithLifecycle()

    // Remember this state, and set it here in UI
    // (just for demo...would be better to keep in viewState instead!)
    var initialized by remember { mutableStateOf(false) }
    var apiSuccess by remember { mutableStateOf(false) }

    // Run on launch of the view
    LaunchedEffect(Unit) {
        // After initialization, the viewModelInitializedEvent will be raised
        viewModel.initializeViewModel()
    }

    // Listen for the initialization event
    EventEffect(
        event = viewState.initializedEvent,
        onConsumed = viewModel::initializedEventConsumed
    ) {
        initialized = true // set remember value on event
    }

    EventEffect(
        event = viewState.fetchEvent,
        onConsumed = viewModel::fetchEventConsumed
    ) { eventData ->
        apiSuccess = eventData.success
    }

    Column {
        Text("ViewModel initialized: $initialized")
        Text("API Success: $apiSuccess")

        if (initialized) {
            if (apiSuccess) {
                LazyColumn {
                    viewState.customerList?.let { list ->
                        list.forEach { name ->
                            item {
                                Text(name)
                            }
                        }
                    }
                }
            } else {
                Button(onClick = { viewModel.fetchDataFromApi() }) {
                    Text("START API CALL")
                }
            }
        }
    }
}