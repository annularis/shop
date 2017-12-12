<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="description" content="{$header.site_description|escape:'html':'UTF-8'}" />
    <title>{$header.title|escape:'html':'UTF-8'} | {$header.site_title|escape:'html':'UTF-8'}</title>
    <link rel="stylesheet" type="text/css"  href="{url type="base_url" url=""}assets/css/bootstrap.css">
    <!-- JavaScript -->
    <script src="{url type="site" url="assets/js/jquery-1.8.1.min.js"}"></script>
    <script src="{url type="site" url="assets/js/bootstrap.js"}"></script>
	{$header.header_meta}
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark sticky-top">
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="container">
		{url type="anchor" url="" text=$header.site_title|escape:"html":"UTF-8" attr="class='navbar-brand'"}
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav ml-auto">
                {if $current_user.user_role eq 'Admin'}
                        <li class="nav-item">
						<a class="nav-link" href="/index.php">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/items">Items</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/admin">Admin</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/inbox">Inbox{if $count_unread_messages gt 0} {$count_unread_messages}{/if}</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/account">Account</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/logout">Logout</a></li>
                    {elseif $current_user.user_role eq 'Buyer'}
                        <li class="nav-item"><a class="nav-link" href="/index.php">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/items">Items</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/inbox">Inbox{if $count_unread_messages gt 0} {$count_unread_messages}{/if}</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/account">Account</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/logout">Logout</a></li>
                    {elseif $current_user.user_role == 'Vendor'}
                        <li class="nav-item"><a class="nav-link" href="/index.php">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/items">Items</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/inbox">Inbox{if $count_unread_messages gt 0} {$count_unread_messages}{/if}</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/account">Account</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/logout">Logout</a></li>

                    {elseif $current_user.user_role == 'half'}
                        {if $allow_guests eq TRUE}
                            <li class="nav-item"><a class="nav-link" href="/index.php">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="/index.php/items">Items</a></li>
                        {/if}
                        <li class="nav-item"><a class="nav-link">Logout</a></li>
                    {else}
                        {if $allow_guests eq TRUE}
                            <li class="nav-item"><a class="nav-link" href="/index.php">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="/index.php/items">Items</a></li>
                        {/if}
                        <li class="nav-item"><a class="nav-link" href="/index.php/login">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="/index.php/register">Register</a></li>
                    {/if}
            </ul>
		</div>
	</div>  
</nav>
<br>
<!-- left-side-bar-space -->
 <div class="container">
        <div class="row">
            <!-- sidebar-nav -->
            <div class="col-lg-3">
                {if in_array($current_user.user_role, ['guest','half']) eq FALSE}
                <!-- Logged in bar-->
                <div class="list-group">
                    {capture name="t_user_link"}user/{$current_user.user_hash}{/capture}
                    {url type="anchor" url=$smarty.capture.t_user_link text=$current_user.user_name|escape:"html":"UTF-8" attr="class='list-group-item' title='Your Profile'"}

                    {if $current_user['user_role'] eq 'Vendor'}
                        {url type="anchor" url="listings" text="My Listings" attr="class='list-group-item' title='My Listings'"}
                        {url type="anchor" url="orders" text="Orders" attr="class='list-group-item' title='Orders'"}
                    {elseif $current_user['user_role'] eq 'Admin'}
                        {url type="anchor" url="admin/orders" text="Orders" attr="class='list-group-item' title='Orders'"}
                        {url type="anchor" url="admin/disputes" text="Disputes" attr="class='list-group-item' title='Disputes'"}
                    {elseif $current_user['user_role'] eq 'Buyer'}
                        {url type="anchor" url="purchases" text="My Purchases" attr="class='list-group-item' title='Your Purchases'"}
                    {/if}
                </div>
				{/if}

				{if $category_data.block eq FALSE}<div class="card bg-light card-body mb-3 sidebar-nav">
					<ul class="nav navbar-nav list-inline">
						<h6>Categories:</h6>
						{$category_data.cats}
					</ul>
				</div>
				{/if}

        </div>
<!-- /sidebar-nav -->