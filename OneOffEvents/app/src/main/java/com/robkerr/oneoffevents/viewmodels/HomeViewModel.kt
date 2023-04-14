package com.robkerr.oneoffevents.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.robkerr.oneoffevents.models.ApiResponse
import dagger.hilt.android.lifecycle.HiltViewModel
import de.palm.composestateevents.StateEvent
import de.palm.composestateevents.StateEventWithContent
import de.palm.composestateevents.consumed
import de.palm.composestateevents.triggered
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class HomeViewState (
    // Flag that ViewModel has been initialized
    val initialized: Boolean = false,
    // Customer Data for UI to display
    val customerList: List<String>? = null,

    // Each event begins as a consumed event. ViewModel triggers them, View observes them
    val fetchEvent: StateEventWithContent<ApiResponse> = consumed(),
    val initializedEvent: StateEvent = consumed
)

@HiltViewModel
class HomeViewModel @Inject constructor(
) : ViewModel() {

    // Create view state shared with view
    private val _viewState = MutableStateFlow(HomeViewState())
    val viewState = _viewState.asStateFlow()

    fun fetchEventConsumed() {
        // Could add additional logic here

        _viewState.update { it.copy(fetchEvent = consumed()) }
    }

    fun initializedEventConsumed() {
        // Could add additional logic here

        _viewState.update { it.copy(fetchEvent = consumed()) }
    }

    fun initializeViewModel() {
        // Just to demonstrate an event having no associated content
        viewModelScope.launch {
            delay(2000L)

            // UI can observe this event raised, but there is no payload provided
            _viewState.update {
                it.copy(
                    initializedEvent = triggered
                )
            }
        }
    }

    fun fetchDataFromApi() {
        viewModelScope.launch {

            // Simulate receiving data from Web API call after 2 seconds
            delay(2000L)
            val data = ApiResponse(true, listOf("Company A", "Company B", "Company C"))

            // Save data in view state & raise event with payload
            // so UI can update display appropriately
            _viewState.update {
                it.copy(
                    customerList = data.customerList,
                    fetchEvent = triggered(data)
                )
            }
        }
    }
}