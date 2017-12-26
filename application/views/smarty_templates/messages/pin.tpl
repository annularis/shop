            <div class="col-lg-9">
                <h2>Message's PIN</h2>

                {assign var="defaultMessage" value="You must enter your PIN to decrypt your messages"}
                {returnMessage defaultMessage="$defaultMessage" returnMessage="$returnMessage" class="$returnMessage_class"}

                {form method="open" action="message/pin" attr=['class'=>'form-horizontal']}
                    <div class="form-group">
                        <div class="col-12">
                            <label class="col-2 control-label" for="pin">PIN</label>
                            <div class="col-6">
                                <input type='password' name='pin' id="pin" class="form-control" value="" autocomplete="off"/>
                            </div>
                        </div>
                        <div class="col-10 mx-auto">{form method="form_error" field="pin"}</div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2 col-xl-2 col-lg-2" for="submit"></label>
                        <div class="col-md-5 col-xl-5 col-lg-5">
                            <p align="center">
                                <button type='submit' class="btn btn-primary">Submit</button>
                                {url type="anchor" url="home" text="Cancel" attr='class="btn btn-danger"'}
                            </p>
                        </div>
                    </div>
                </form>
            </div>
