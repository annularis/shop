            {capture name="t_pubkeys_url"}accounts/public_keys{/capture}
            {capture name="t_buyer_url"}user/{$order.buyer.user_hash}{/capture}
            {capture name="t_accept_order_url"}orders/accept/{$order.id}{/capture}

                    <div class="col-lg-9" id="vendor_public_keys">
                <h2>Accept Order {$order.id}</h2>

                {assign var="defaultMessage" value=""}
                {returnMessage defaultMessage="$defaultMessage" returnMessage="$returnMessage" class="$returnMessage_class"}

                {if $vendor_public_key == FALSE}
                    You cannot proceed with this order until you set up a source of public keys. {url type="anchor" url=$smarty.capture.t_pubkeys_url text="Click here to set this up" attr=""}
                {else}
                    A public key will automatically be used to create the order address.
                {/if}

                <br /><br />
                {form method="open" action=$smarty.capture.t_accept_order_url attr='class="form-horizontal"'}
                    <div class="row">

                        <div class="col-10 mx-auto">
                            <div class="table-responsive">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Order with {url type="anchor" url=$smarty.capture.t_buyer_url text=$order.buyer.user_name|escape:"html":"UTF-8" attr=''}:</div>

                                    <table class="table table-striped">
                                        <tbody>
                                        {foreach from=$order.items item=item}
                                            {capture name="t_item_url"}item/{$item.hash}{/capture}
                                            <tr>
                                                <td>{$item.quantity|escape:"html":"UTF-8"} x</td>
                                                <td>{url type="anchor" url=$smarty.capture.t_item_url text=$item.name attr=''}</td>
                                                <td>{$coin.code} {number_format($item.quantity*$item.price_b,8)}</td>
                                            </tr>
                                        {/foreach}
                                        <tr>
                                            <td></td>
                                            <td>Shipping to {$order.buyer.location_f}</td>
                                            <td>{$coin.code} {$fees.shipping_cost}</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Fees</td>
                                            <td>{$coin.code} {$fees.vendor_fees}</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><strong>Total</strong></td>
                                            <td>{$coin.code} {$order.total_paid}</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><strong>Earnings</strong></td>
                                            <td>{$coin.code} {number_format($order.total_paid-$fees.vendor_fees,8)}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-9 col-offset-3">Your order will be <strong>{$order_type}</strong>.</div>
                    </div>

                    <div class='col-12'>&nbsp;</div>

                    <input type="hidden" name="vendor_accept_order_id" value="{$order.id}" />

                    <div class="form-group">
                        <label class="control-label col-md-2 col-xl-2 col-lg-2" for="submit"></label>
                        <div class="col-md-5 col-xl-5 col-lg-5">
                            <p align="center">
                                <input type='submit' class="btn btn-primary" name='vendor_accept_order' value='Accept Order' onclick='messageEncrypt()' />
                                {url type="anchor" url="orders" text="Cancel" attr='title="Cancel" class="btn btn-danger"'}
                            </p>
                        </div>
                    </div>

                </form>
            </div>
