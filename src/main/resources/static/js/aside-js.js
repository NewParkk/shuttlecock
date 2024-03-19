/* aside - active 상태유지*/
document.addEventListener('DOMContentLoaded', function() {
    var menuItems = document.querySelectorAll('.menubar .list');
    var currentPageUrl = window.location.href;

    menuItems.forEach(function(item) {
        var menuItemUrl = item.getAttribute('href');

        //현재 URL이 메뉴 URL과 일치하면 active 추가
        if (currentPageUrl.includes(menuItemUrl)) {
            item.classList.add('active');
        }

        //클릭된 메뉴에 active 추가
        item.addEventListener('click', function(event) {
            menuItems.forEach(function(menuItem) {
                menuItem.classList.remove('active');
            });
            this.classList.add('active');
        });
    });
});