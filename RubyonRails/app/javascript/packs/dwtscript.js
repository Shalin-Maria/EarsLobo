document.addEventListener('turbolinks:load', function() {
   
    document.addEventListener('DOMContentLoaded', function() {
        // Disable scrolling
        document.body.style.overflow = 'hidden';

        // Enable scrolling
        // document.body.style.overflow = 'auto';
    });

    //function for keeping the buttons blue after being clicked
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');

    checkboxes.forEach(function(checkbox) {
    checkbox.addEventListener('change', function() {
        const label = this.closest('label');
        if (this.checked) {
        label.classList.add('active');
        } else {
        label.classList.remove('active');
        }
    });
    });

    //script completes all logic for calculating diagnosis and ear advantage values, It updates the percentages and lists the ear diag and advantage
    // Get the toggle buttons and count elements
    const column1Buttons = document.querySelectorAll(".column1-button input[type='checkbox']");
    const column2Buttons = document.querySelectorAll(".column2-button input[type='checkbox']");
    const allButtons = document.querySelectorAll(".column1-button input[type='checkbox'], .column2-button input[type='checkbox']");
    const column1Count = document.getElementById("column1-count");
    const column2Count = document.getElementById("column2-count");
    const column1Percent = document.getElementById("column1-percent");
    const column2Percent = document.getElementById("column2-percent");
    const advantageDiff = document.getElementById("advantage-Diff");
    const advantageName = document.getElementById("advantage-Name");
    const testDiagnosis = document.getElementById("Diagnosis");
    const readOnly = document.getElementById("read-Only");
    const readOnlyDiag = document.getElementById("read-Only-diag");



    // Update the counts when a button is clicked

    allButtons.forEach(function(button) {
    button.addEventListener("click", function() {
    const checkedCount1 = document.querySelectorAll(".column1-button input[type='checkbox']:checked").length;
    const checkedCount2 = document.querySelectorAll(".column2-button input[type='checkbox']:checked").length;
    const totalCount1 = column1Buttons.length;
    const totalCount2 = column2Buttons.length;
    const percent1 = ((checkedCount1 / totalCount1) * 100).toFixed(2);
    const percent2 = ((checkedCount2 / totalCount2) * 100).toFixed(2);
    const advantage = (percent1 - percent2).toFixed(2);
    const avgPercent = ((+percent1 + +percent2) / 2).toFixed(2);

    let direction = null;
    let interpretation = null;
    const ageElement = document.getElementById('age');
    const age = parseInt(ageElement.dataset.age);
    let dom = null;
    let nondom = null;
    if (advantage > 0) {
        direction = "Left";
        dom = percent1;
        nondom = percent2;
    } else if (advantage < 0) {
        direction = "Right";
        dom = percent2;
        nondom = percent1;
    } else {
        direction = "Neutral";
        }
    // IF else logic for diagnosis based on the childs age. Still unsure if this works as intended accoring to Employer, but we believe it is
    if (age == 5 || age == 6){
        if (direction == "Neutral"){
        if (percent1 <= 44){
            interpretation = "Dichotic Dysaudia";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }
        else{
        if (((dom <= 64) || (nondom <= 44)) && ((advantage <= -32) || (advantage >= 32))){
            interpretation = "Amblyaudia + Dichotic Dysaudia";
        }
        else if ((dom <= 64) || (nondom <= 44)){
            interpretation = "Dichotic Dysaudia";
        }
        else if (((dom > 64) && (nondom > 44)) && (advantage <= -32)){
            interpretation = "Ambylaudia Right Ear Dominant";
        }
        else if (((dom > 64) && (nondom > 44)) && (advantage >= 32)){
            interpretation = "Ambylaudia Left Ear Dominant";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }            
    }
    if (age >= 7 && age <= 9){
        if (direction == "Neutral"){
        if (percent1 <= 60){
            interpretation = "Dichotic Dysaudia";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }
        else{
        if (((dom <= 76) || (nondom <= 60)) && ((advantage <= -24) || (advantage >= 24))){
            interpretation = "Amblyaudia + Dichotic Dysaudia";
        }
        else if ((dom <= 76) || (nondom <= 60)){
            interpretation = "Dichotic Dysaudia";
        }
        else if (((dom > 76) && (nondom > 60)) && (advantage <= -24)){
            interpretation = "Ambylaudia Right Ear Dominant";
        }
        else if (((dom > 76) && (nondom > 60)) && (advantage >= 24)){
            interpretation = "Ambylaudia Left Ear Dominant";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }          
    }
    if (age >= 10 && age <= 12){
        if (direction == "Neutral"){
        if (percent1 <= 72){
            interpretation = "Dichotic Dysaudia";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }
        else{
        if (((dom <= 84) || (nondom <= 72)) && ((advantage <= -20) || (advantage >= 20))){
            interpretation = "Amblyaudia + Dichotic Dysaudia";
        }
        else if ((dom <= 84) || (nondom <= 72)){
            interpretation = "Dichotic Dysaudia";
        }
        else if (((dom > 84) && (nondom > 72)) && (advantage <= -20)){
            interpretation = "Ambylaudia Right Ear Dominant";
        }
        else if (((dom > 84) && (nondom > 72)) && (advantage >= 20)){
            interpretation = "Ambylaudia Left Ear Dominant";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }
    }
    if (age >= 13 && age <= 15){
        if (direction == "Neutral"){
        if (percent1 <= 76){
            interpretation = "Dichotic Dysaudia";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }
        else{
        if (((dom <= 92) || (nondom <= 76)) && ((advantage <= -16) || (advantage >= 16))){
            interpretation = "Amblyaudia + Dichotic Dysaudia";
        }
        else if ((dom <= 92) || (nondom <= 76)){
            interpretation = "Dichotic Dysaudia";
        }
        else if (((dom > 92) && (nondom > 76)) && (advantage <= -16)){
            interpretation = "Ambylaudia Right Ear Dominant";
        }
        else if (((dom > 92) && (nondom > 76)) && (advantage >= 16)){
            interpretation = "Ambylaudia Left Ear Dominant";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }          
    }
    if (age >= 16 && age <= 18){
        if (direction == "Neutral"){
        if (percent1 <= 80){
            interpretation = "Dichotic Dysaudia";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }
        else{
        if (((dom <= 88) || (nondom <= 80)) && ((advantage <= -14) || (advantage >= 14))){
            interpretation = "Amblyaudia + Dichotic Dysaudia";
        }
        else if ((dom <= 88) || (nondom <= 80)){
            interpretation = "Dichotic Dysaudia";
        }
        else if (((dom > 88) && (nondom > 80)) && (advantage <= -14)){
            interpretation = "Ambylaudia Right Ear Dominant";
        }
        else if (((dom > 88) && (nondom > 80)) && (advantage >= 14)){
            interpretation = "Ambylaudia Left Ear Dominant";
        }
        else{
            interpretation = "Within Normal Limits";
        }
        }          
    }
    // Passes values to strings so they can be pushed to the html above
    column1Count.innerText = checkedCount1.toString();
    column1Percent.innerText = percent1.toString();
    column2Count.innerText = checkedCount2.toString();
    column2Percent.innerText = percent2.toString();
    advantageDiff.innerText = advantage.toString();
    advantageName.innerText = direction;
    testDiagnosis.innerText = interpretation;
    readOnly.value = advantageName.innerText;
    readOnlyDiag.value = testDiagnosis.innerText;

    })
    })
    
});

