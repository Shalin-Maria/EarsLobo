
  
document.addEventListener('turbolinks:load', function() {

    

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
      const column1ButtonsGroup1 = document.querySelectorAll(".column1Group1-button input[type='checkbox']");
      const column1ButtonsGroup2 = document.querySelectorAll(".column1Group2-button input[type='checkbox']");
      const column1ButtonsGroup3 = document.querySelectorAll(".column1Group3-button input[type='checkbox']");
      const column2ButtonsGroup1 = document.querySelectorAll(".column2Group1-button input[type='checkbox']");
      const column2ButtonsGroup2 = document.querySelectorAll(".column2Group2-button input[type='checkbox']");
      const column2ButtonsGroup3 = document.querySelectorAll(".column2Group3-button input[type='checkbox']");

      const allButtons = document.querySelectorAll(".column1Group1-button input[type='checkbox'], .column1Group2-button input[type='checkbox'], .column1Group3-button input[type='checkbox'], .column2Group1-button input[type='checkbox'], .column2Group2-button input[type='checkbox'], .column2Group3-button input[type='checkbox']");
      
      const column1Count = document.getElementById("column1-count");
      const column2Count = document.getElementById("column2-count");
      
      const column1Group1Percent = document.getElementById("column1Group1-percent");
      const column1Group2Percent = document.getElementById("column1Group2-percent");
      const column1Group3Percent = document.getElementById("column1Group3-percent");
      const column2Group1Percent = document.getElementById("column2Group1-percent");
      const column2Group2Percent = document.getElementById("column2Group2-percent");
      const column2Group3Percent = document.getElementById("column2Group3-percent");

      const advantageDiffGroup1 = document.getElementById("Group1advantage-Diff");
      const advantageDiffGroup2 = document.getElementById("Group2advantage-Diff");
      const advantageDiffGroup3 = document.getElementById("Group3advantage-Diff");



      const advantageName = document.getElementById("advantage-Name");
      const testDiagnosis = document.getElementById("Diagnosis");
      const readOnly = document.getElementById("read-Only");
      const readOnlyDiag = document.getElementById("read-Only-diag");
      


      // Update the counts when a button is clicked
      
      allButtons.forEach(function(button) {
        button.addEventListener("click", function() {
        const checkedCount1Group1 = document.querySelectorAll(".column1Group1-button input[type='checkbox']:checked").length;
        const checkedCount1Group2 = document.querySelectorAll(".column1Group2-button input[type='checkbox']:checked").length;
        const checkedCount1Group3 = document.querySelectorAll(".column1Group3-button input[type='checkbox']:checked").length;
        const checkedCount2Group1 = document.querySelectorAll(".column2Group1-button input[type='checkbox']:checked").length;
        const checkedCount2Group2 = document.querySelectorAll(".column2Group2-button input[type='checkbox']:checked").length;
        const checkedCount2Group3 = document.querySelectorAll(".column2Group3-button input[type='checkbox']:checked").length;

        const totalCountColumn1Group1 = column1ButtonsGroup1.length;
        const totalCountColumn1Group2 = column1ButtonsGroup2.length;
        const totalCountColumn1Group3 = column1ButtonsGroup3.length;
        const totalCountColumn2Group1 = column2ButtonsGroup1.length;
        const totalCountColumn2Group2 = column2ButtonsGroup2.length;
        const totalCountColumn2Group3 = column2ButtonsGroup3.length;


        const percentColumn1Group1 = ((checkedCount1Group1 / totalCountColumn1Group1) * 100).toFixed(2);
        const percentColumn1Group2 = ((checkedCount1Group2 / totalCountColumn1Group2) * 100).toFixed(2);
        const percentColumn1Group3 = ((checkedCount1Group3 / totalCountColumn1Group3) * 100).toFixed(2);
        const percentColumn2Group1 = ((checkedCount2Group1 / totalCountColumn2Group1) * 100).toFixed(2);
        const percentColumn2Group2 = ((checkedCount2Group2 / totalCountColumn2Group2) * 100).toFixed(2);
        const percentColumn2Group3 = ((checkedCount2Group3 / totalCountColumn2Group3) * 100).toFixed(2);

        const group1Advantage = (percentColumn1Group1 - percentColumn2Group1).toFixed(2);
        const group2Advantage = (percentColumn1Group2 - percentColumn2Group2).toFixed(2);
        const group3Advantage = (percentColumn1Group3 - percentColumn2Group3).toFixed(2);

        let direction = null;
        console.log(group1Advantage + group2Advantage + group3Advantage);
        if ((parseFloat(group1Advantage) + parseFloat(group2Advantage) + parseFloat(group3Advantage)) > 0) {
          direction = "Left";
        }
        else if ((parseFloat(group1Advantage) + parseFloat(group2Advantage) + parseFloat(group3Advantage)) < 0) {
          direction = "Right";
        }
        else{
          direction = "Neutral";
        }


        /*
        const advantage = (percent1 - percent2).toFixed(2);
        const avgPercent = ((+percent1 + +percent2) / 2).toFixed(2);

        let direction = null;
        let interpretation = null;
        let age = 40;
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
// IF else logic for diagnosis based on the childs age. Still unsure if this works as intended accoring to Employer, but we believe it does
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
        */
        // Passes values to strings so they can be pushed to the html above


        column1Group1Percent.innerText = percentColumn1Group1.toString();
        column1Group2Percent.innerText = percentColumn1Group2.toString();
        column1Group3Percent.innerText = percentColumn1Group3.toString();

        column2Group1Percent.innerText = percentColumn2Group1.toString();
        column2Group2Percent.innerText = percentColumn2Group2.toString();
        column2Group3Percent.innerText = percentColumn2Group3.toString();



        advantageDiffGroup1.innerText = group1Advantage.toString();
        advantageDiffGroup2.innerText = group2Advantage.toString();
        advantageDiffGroup3.innerText = group3Advantage.toString();


        advantageName.innerText = direction;
        readOnly.value = advantageName.innerText;

        /*
        testDiagnosis.innerText = interpretation;
        readOnly.value = advantageName.innerText;
        readOnlyDiag.value = testDiagnosis.innerText;
*/
        })
      })
    // gets the elements from hidden field submit above and populates them from the results in the script 
    function populateHiddenFields() {
      document.getElementById("left_score").value = column1Percent.innerText;
      document.getElementById("right_score").value = column2Percent.innerText;
      document.getElementById("ear_advantage").value = advantageName.innerText;
      document.getElementById("ear_advantage_score").value = advantageDiff.innerText;
    }


});
  